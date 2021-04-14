import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:kilo/bloc/login/login_bloc.dart';

class WalletDataRepo {
  String date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  getbalance() async{
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(loginBloc.emailID)
        .get();
  }
   
  addMoney(double amount) async{
    await FirebaseFirestore.instance
      .collection('users')
      .doc(loginBloc.emailID)
      .update({'Balance': FieldValue.increment(amount)});
    createTransaction(amount, 'Add', null, null);
  }

  spendMoney(double amount, String item, String image) async{
    await FirebaseFirestore.instance
      .collection('users')
      .doc(loginBloc.emailID)
      .update({'Balance': FieldValue.increment(-amount)});
    createTransaction(amount, 'Spend', item, image);
  }

  createTransaction(double amount, String type, String item, String image) async{
    Map<String, dynamic> map = {
      'Date': date,
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
