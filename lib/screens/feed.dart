import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/posts_bloc.dart';
import 'package:kilo/bloc/user_details/user_details_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/repository/likes_repo.dart';
import 'package:kilo/screens/new_feed.dart';
import 'package:kilo/screens/post.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/progress_indicator.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  ScrollController controller = ScrollController();
  
  onRefresh() async{
    bloc.loadingStatusIn.add(true);
    await Future.delayed(Duration(seconds: 3));
    await postBloc.getPosts();
    bloc.loadingStatusIn.add(false);
  }

  @override
  void initState() {
    super.initState();
    postBloc.getPosts();
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.of(context).size.height*0.25;
      if(maxScroll - currentScroll <= delta){
        postBloc.getNextPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: underlineText('Feed', 24, Colors.black), 
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_outlined), 
            onPressed: ()=> navigate(context, NewFeed(refresh: onRefresh), PageTransitionAnimation.slideUp, false), 
            color: Colors.grey[800],
            splashColor: Colors.orange[400],
            splashRadius: 15
          ),
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: ()=> onRefresh(), 
            color: Colors.grey[800],
            splashColor: Colors.orange[400],
            splashRadius: 15
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: StreamBuilder(
              stream: postBloc.postsOut,
              builder: (context, posts) {
                if(!posts.hasData){
                  bloc.loadingStatusIn.add(true);
                  return Text('Loading...');
                }
                else{
                  bloc.loadingStatusIn.add(false);
                  return ListView.builder(
                    itemCount: posts.data.length,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => navigate(context, Post(post: posts.data[index],), PageTransitionAnimation.slideUp, false), 
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(20),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle, color: Colors.grey[800], size: 40,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(posts.data[index].data()['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                              Text(posts.data[index].data()['Date'], style: TextStyle(color: Colors.grey,fontSize: 14)), 
                                            ]
                                          ),
                                        ),
                                      ]
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(posts.data[index].data()['Text'], style: TextStyle(color: Colors.grey[800],fontSize: 16)),
                                    ),
                                    posts.data[index].data()['Image'] != null?
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        height: screenSize(200, context),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(posts.data[index].data()['Image']),
                                            fit: BoxFit.fill
                                          )
                                        ),
                                      )
                                    ) : Container()
                                  ],
                                )
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => likesRepo.onLikeClicked(posts.data[index].id),
                                    child: StreamBuilder<Object>(
                                      stream: userDetailsBloc.likedOut,
                                      builder: (context, snap) {
                                        return Container(
                                          padding: const EdgeInsets.only(top:8, bottom: 8, left: 20, right:20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: loginBloc.liked.contains(posts.data[index].id) ? Colors.orange[200] : Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(FontAwesomeIcons.smile, size: 18,),
                                              Padding(
                                                padding: const EdgeInsets.only(left:8),
                                                child: Text(posts.data[index].data()['Likes'].toString(), style: TextStyle(fontSize: 15),),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    )
                                  ),
                                  GestureDetector(
                                    onTap: () => navigate(context, Post(post: posts.data[index],), PageTransitionAnimation.slideUp, false),
                                    child: Container(
                                      padding: const EdgeInsets.only(top:8, bottom: 8, left: 20, right:20),
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.commentAlt, size: 18,),
                                          Padding(
                                            padding: const EdgeInsets.only(left:8),
                                            child: Text(posts.data[index].data()['Comments'].toString(), style: TextStyle(fontSize: 15),),
                                          )
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            ),
          ),
          Positioned(
            bottom: 20,
            child: progressIndicator(context)
          )
        ]
      )
    );
  }
}