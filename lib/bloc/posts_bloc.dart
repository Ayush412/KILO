import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/posts_repo.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<List<DocumentSnapshot>> postsController = BehaviorSubject();

  //SINKS
  Sink<List<DocumentSnapshot>> get postsIn => postsController.sink;

  //STREAMS
  Stream<List<DocumentSnapshot>> get postsOut => postsController.stream;

  getPosts(){
    postsRepo.getPosts();
  }

  getNextPosts(){
    postsRepo.getNextPosts();
  }

  @override
  void dispose() {
    postsController.close();
  }
}
final postBloc = PostsBloc();