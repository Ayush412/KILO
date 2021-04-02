import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/repository/posts_repo.dart';
import 'package:kilo/screens/crop_imaged.dart';
import 'package:kilo/widgets/circular_progress.dart';
import 'package:kilo/widgets/progress_indicator.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/widgets/show_snack.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NewFeed extends StatefulWidget {
  VoidCallback refresh;
  NewFeed({this.refresh});
  @override
  _NewFeedState createState() => _NewFeedState();
}

class _NewFeedState extends State<NewFeed> {

  TextEditingController controller = TextEditingController();
  String text = '';
  File image;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  close(){
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  clearImage(){
    setState(() {
      image = null;
    });
  }

  onDone(dynamic crop){
    setState(() {
      image = crop;
    });
  }

  getImage() async{
    var file = await picker.getImage(source: ImageSource.gallery);
    if(file!=null){
      navigate(context, CropScreen(file: File(file.path), onDone: onDone), PageTransitionAnimation.sizeUp, false);
    }
  }

  post() async{
    var conn = await (Connectivity().checkConnectivity());
    String text = controller.text;
    text.replaceAll(' ', '');
    if(controller.text==null || controller.text=='' || text.length==0)
      scaffoldKey.currentState.showSnackBar(showSnack('Content can not be blank.', Colors.black, Colors.orange[400]));
    else{
      if(conn == ConnectivityResult.none)
        scaffoldKey.currentState.showSnackBar(showSnack('No internet connection!', Colors.white, Colors.red[700]));
      else{
        bloc.loadingStatusIn.add(true);
        await postsRepo.addPost(text, image);
        bloc.loadingStatusIn.add(false);
        widget.refresh();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialogBox(context, 'Discard?', 'Changes will not be saved.', close),
        child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: underlineText('Create Post', 24, Colors.black), 
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => showDialogBox(context, 'Discard?', 'Changes will not be saved.', close),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          actions: [
            StreamBuilder(
              stream: bloc.loadingStatusOut,
              builder: (context, snapshot) {
                if(snapshot.data)
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[400])
                        )
                      ),
                    )
                  );
                else
                  return Center(
                    child: GestureDetector(
                      onTap: () => post(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("POST", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                    ),
                  );
              },
            )
          ],
          elevation: 0.5,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SingleChildScrollView(
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text('Content', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: controller,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Write something...',
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const  EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Text('Image (optional)', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                    child: Expanded(
                      child: AspectRatio(
                        aspectRatio: 3/2,
                        child: image==null? GestureDetector(
                          onTap: () => getImage(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 35, color: Colors.grey),
                                  Text('Add Image', style: TextStyle(color: Colors.grey, fontSize: 20))
                                ],
                              )
                            ),
                          ),
                        ):
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              color: Colors.grey[400].withOpacity(0.5),
                              shape: CircleBorder(),
                              onPressed: () => clearImage(),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ),   
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}