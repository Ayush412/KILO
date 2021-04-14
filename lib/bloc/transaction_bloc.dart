import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/transactions_repo.dart';
import 'package:rxdart/rxdart.dart';

class TransactionsBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<QuerySnapshot> transactionsController = BehaviorSubject<QuerySnapshot>();

  //SINKS
  Sink<QuerySnapshot> get transactionsIn => transactionsController.sink;

  //STREAMS
  Stream<QuerySnapshot> get transactionsOut => transactionsController.stream;

  getOrders() async{
    transactionsIn.add(await transactionsRepo.getTransactions());
  }

  @override
  void dispose() {
    transactionsController.close();
  }

}

final TransactionsBloc transactionsBloc = TransactionsBloc();