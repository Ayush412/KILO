import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/posts_bloc.dart';

class PostsRepo{
  List<DocumentSnapshot> posts = [];
  DocumentSnapshot lastDoc;
  bool moreLoading = false;
  bool moreDocsLeft = true;

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
}
final postsRepo = PostsRepo();