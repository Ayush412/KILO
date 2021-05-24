import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/products_bloc.dart';

class ProductsRepo{

  getProducts() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('products').get();
    productsBloc.productsIn.add(qs.docs);
  }

}

final productsRepo = ProductsRepo();