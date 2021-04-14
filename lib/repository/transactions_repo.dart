import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class TransactionsRepo{

  getTransactions() async{
    QuerySnapshot qs = await FirebaseFirestore.instance
      .collection('users/${loginBloc.emailID}/Transactions')
      .orderBy('Date', descending: true)
      .get();
    return qs;
  }
}

final TransactionsRepo transactionsRepo = TransactionsRepo();