import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/transactions_repo.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<QuerySnapshot> _ordersController = BehaviorSubject<QuerySnapshot>();

  //SINKS
  Sink<QuerySnapshot> get ordersIn => _ordersController.sink;

  //STREAMS
  Stream<QuerySnapshot> get ordersOut => _ordersController.stream;

  getOrders() async{
    ordersIn.add(null);
    ordersIn.add(await transactionsRepo.getTransactions());
  }

  @override
  void dispose() {
    _ordersController.close();
  }

}

final OrdersBloc ordersBloc = OrdersBloc();