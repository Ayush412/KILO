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
  }

  spendMoney(double amount) async{
    await FirebaseFirestore.instance
      .collection('users')
      .doc(loginBloc.emailID)
      .update({'Balance': FieldValue.increment(-amount)});
  }

}

final walletRepo = WalletDataRepo();
