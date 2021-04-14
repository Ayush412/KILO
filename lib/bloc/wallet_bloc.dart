import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/wallet_repo.dart';
import 'package:rxdart/rxdart.dart';

class WalletBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<QuerySnapshot> transactionsController = BehaviorSubject<QuerySnapshot>();
  BehaviorSubject<double> balanceController = BehaviorSubject<double>();

  //SINKS
  Sink<QuerySnapshot> get transactionsIn => transactionsController.sink;
  Sink<double> get balanceIn => balanceController.sink;

  //STREAMS
  Stream<QuerySnapshot> get transactionsOut => transactionsController.stream;
  Stream<double> get balanceOut => balanceController.stream;

  getOrders() async{
    transactionsIn.add(await walletRepo.getTransactions());
  }

  getBalance() async{
    balanceIn.add(await walletRepo.getbalance());
  }

  @override
  void dispose() {
    transactionsController.close();
    balanceController.close();
  }

}

final WalletBloc walletBloc = WalletBloc();