import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/user_details/user_details_bloc.dart';
import 'package:kilo/repository/posts_repo.dart';

class LikesRepo{

  onLikeClicked(String docId) async{
    if(loginBloc.liked.contains(docId))
      await removeLike(docId);
    else
      await addLike(docId);
  }

  addLike(String docId) async{
    loginBloc.liked.add(docId);
    print(loginBloc.liked);
    userDetailsBloc.likedIn.add(loginBloc.liked);
    await FirebaseFirestore.instance.collection('posts').doc(docId).update({
      'Likes': FieldValue.increment(1)
    });
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update({
      'Liked': loginBloc.liked
    });
  }

  removeLike(String docId) async{
    loginBloc.liked.remove(docId);
    print(loginBloc.liked);
    userDetailsBloc.likedIn.add(loginBloc.liked);
    await FirebaseFirestore.instance.collection('posts').doc(docId).update({
      'Likes': FieldValue.increment(-1),
    });
    await FirebaseFirestore.instance.collection('users').doc(loginBloc.emailID).update({
      'Liked': loginBloc.liked
    });
  }
  
}

final likesRepo = LikesRepo();