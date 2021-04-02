import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/comments_bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class CommentsRepo{

  List<DocumentSnapshot> comments = [];
  DocumentSnapshot lastDoc;
  bool moreLoading = false;
  bool moreDocsLeft = true;
  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  getComments(String docID) async{
    comments = [];
    lastDoc = null;
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('posts/$docID/comments')
    .orderBy('Date', descending: true)
    .limit(10).get();
    comments = qs.docs;
    if(comments.length == 0){
      return null;
    }
    commentsBloc.commentsIn.add(comments);
  }

  getNextComments(String docID) async{
    if(moreDocsLeft == false){
      return;
    }
    if(moreLoading == true){
      return;
    }
    moreLoading = true;
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('posts/$docID/comments')
    .orderBy('Date', descending: true)
    .startAfter([lastDoc.data()['Date']])
    .limit(2).get();
    if(qs.docs.length == 0){
      moreDocsLeft = false;
      return;
    }
    comments.addAll(qs.docs);
    lastDoc = qs.docs[qs.docs.length-1];
    moreLoading = false;
    commentsBloc.commentsIn.add(comments);
  }

  postComment(String text, String docID) async{
    await FirebaseFirestore.instance.collection('posts/$docID/comments').doc().set({
      'Name': loginBloc.userMap['Name'],
      'Text': text,
      'Date': date,
    });
  }
}

final commentsRepo = CommentsRepo();