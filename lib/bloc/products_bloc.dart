import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/repository/produtcs_repo.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc implements BaseBloc{

  //CONTROLLERS
  BehaviorSubject<List<DocumentSnapshot>> productsController = BehaviorSubject();

  //SINKS
  Sink<List<DocumentSnapshot>> get productsIn => productsController.sink;


  //STREAMS
  Stream<List<DocumentSnapshot>> get productsOut => productsController.stream;

  getProducts() async{
    await productsRepo.getProducts();
  }

  @override
  void dispose() {
    productsController.close();
  }
}
final productsBloc = ProductsBloc();