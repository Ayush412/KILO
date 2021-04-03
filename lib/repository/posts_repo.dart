import 'dart:math';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/posts_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class PostsRepo{
  List<DocumentSnapshot> posts = [];
  DocumentSnapshot lastDoc;
  bool moreLoading = false;
  bool moreDocsLeft = true;
  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  getPosts() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('posts')
    .orderBy('Date', descending: true)
    .limit(10).get();
    posts = qs.docs;
    if(posts.length==0){
      return null;
    }
    postBloc.postsIn.add(posts);
  }

  getNextPosts() async{
    if(moreDocsLeft == false){
      return;
    }
    if(moreLoading == true){
      return;
    }
    moreLoading = true;
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('posts')
    .orderBy('Date', descending: true)
    .startAfter([lastDoc.data()['Date']])
    .limit(2).get();
    if(qs.docs.length == 0){
      moreDocsLeft = false;
      return;
    }
    posts.addAll(qs.docs);
    lastDoc = qs.docs[qs.docs.length-1];
    moreLoading = false;
    postBloc.postsIn.add(posts);
  }

  deletePost(String postID) async{
    await FirebaseFirestore.instance.collection('posts').doc(postID).delete();
  }

  addPost(String text, dynamic file) async{
    String url;
    if(file!=null)
      url = await putImage(file);
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'Comments': 0,
      'Likes': 0,
      'Name': loginBloc.userMap['Name'],
      'Text': text,
      'Date': date,
      'Image': url,
      'email': loginBloc.emailID
    });
  }

  putImage(dynamic file) async{
    String url;
    storage.Reference ref = storage.FirebaseStorage.instance
    .ref()
    .child('Posts')
    .child('/${loginBloc.emailID}-${Random().nextInt(10000)}-${Random().nextInt(10000)}-$date.jpg');
    storage.UploadTask upload = ref.putFile(file);
    await upload.whenComplete(()async{
      url = await ref.getDownloadURL();
    });
    return url;
  }
}
final postsRepo = PostsRepo();