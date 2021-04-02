import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/comments_bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/user_details/user_details_bloc.dart';
import 'package:kilo/repository/comments_repo.dart';
import 'package:kilo/repository/likes_repo.dart';
import 'package:kilo/screensize.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/widgets/comments.dart';
import 'package:kilo/widgets/textfield.dart';

class Post extends StatefulWidget {
  final DocumentSnapshot post;
  Post({this.post});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  ScrollController controller = ScrollController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentsBloc.commentsIn.add(null);
    commentsBloc.getComments(widget.post.id);
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.of(context).size.height*0.25;
      if(maxScroll - currentScroll <= delta){
        commentsBloc.getNextComments(widget.post.id);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey[800],
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(Icons.account_circle, color: Colors.grey[800], size: 50,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.post.data()['Name'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                                Text(widget.post.data()['Date'], style: TextStyle(color: Colors.grey,fontSize: 14)),  
                              ]
                            ),
                          ),
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(widget.post.data()['Text'], style: TextStyle(color: Colors.grey[800],fontSize: 16)),
                    ),
                    widget.post.data()['Image'] != null?
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: screenSize(200, context),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(widget.post.data()['Image']),
                            fit: BoxFit.fill
                          )
                        ),
                      )
                    ) : Container(),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => likesRepo.onLikeClicked(widget.post.id),
                            child: StreamBuilder<Object>(
                              stream: userDetailsBloc.likedOut,
                              builder: (context, snapshot) {
                                return Container(
                                  padding: const EdgeInsets.only(top:8, bottom: 8, left: 20, right:20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: loginBloc.liked.contains(widget.post.id) ? Colors.orange[200] : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.smile, size: 18,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8),
                                        child: Text(widget.post.data()['Likes'].toString(), style: TextStyle(fontSize: 15),),
                                      )
                                    ],
                                  ),
                                );
                              }
                            )
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(top:8, bottom: 8, left: 20, right:20),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.commentAlt, size: 18,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8),
                                    child: Text(widget.post.data()['Comments'].toString(), style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text("Comments:", style: TextStyle(fontSize: 15),)
                      ),
                    ),
                    Divider(),
                    comments(controller)
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}