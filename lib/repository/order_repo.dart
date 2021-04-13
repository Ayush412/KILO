import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class OrdersRepo{

  getOrders() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('users/${loginBloc.emailID}/Orders').orderBy('Date', descending: true).get();
    return qs;
  }
  
}

final OrdersRepo ordersRepo = OrdersRepo();