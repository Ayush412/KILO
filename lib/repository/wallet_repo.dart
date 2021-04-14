import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/wallet_bloc.dart';

class WalletDataRepo {

  getTransactions() async{
    QuerySnapshot qs = await FirebaseFirestore.instance
      .collection('users/${loginBloc.emailID}/Transactions')
      .orderBy('Date', descending: true)
      .get();
    return qs;
  }

  getbalance() async{
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(loginBloc.emailID)
        .get();
    return ds.data()['Balance'];
  }
   
  addMoney(double amount) async{
    await FirebaseFirestore.instance
      .collection('users')
      .doc(loginBloc.emailID)
      .update({'Balance': FieldValue.increment(amount)});
    await createTransaction(amount, 'Add', null, null);
    await walletBloc.getBalance();
    await walletBloc.getOrders();
  }

  spendMoney(double amount, String item, String image) async{
    await FirebaseFirestore.instance
      .collection('users')
      .doc(loginBloc.emailID)
      .update({'Balance': FieldValue.increment(-amount)});
    await createTransaction(amount, 'Spend', item, image);
    await walletBloc.getBalance();
    await walletBloc.getOrders();
  }

  createTransaction(double amount, String type, String item, String image) async{
    Map<String, dynamic> map = {
      'Date': DateTime.now(),
      'Amount': amount,
      'Type': type
    };
    if(item != null){
      map['Item'] = item;
      map['Image'] = image;
    }
    await FirebaseFirestore.instance
      .collection('users/${loginBloc.emailID}/Transactions')
      .doc()
      .set(map);
  }
}

final walletRepo = WalletDataRepo();
