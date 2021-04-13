import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class OrdersRepo{

  getOrders() async{
    QuerySnapshot qs = await Firestore.instance.collection('users/${loginBloc.userMap['emailID']}/Orders').orderBy('Date', descending: true).getDocuments();
    return qs;
  }

}

final OrdersRepo ordersRepo = OrdersRepo();