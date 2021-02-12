import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/comments_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<List<DocumentSnapshot>> commentsController = BehaviorSubject();

  //SINKS
  Sink<List<DocumentSnapshot>> get commentsIn => commentsController.sink;

  //STREAMS
  Stream<List<DocumentSnapshot>> get commentsOut => commentsController.stream;

  getComments(String docID){
    commentsRepo.getComments(docID);
  }

  getNextComments(String docID){
    commentsRepo.getNextComments(docID);
  }

  @override
  void dispose() {
    commentsController.close();
  }
}
final commentsBloc = CommentsBloc();