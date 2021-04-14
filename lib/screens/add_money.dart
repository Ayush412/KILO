import 'package:flutter/material.dart';
import 'package:kilo/bloc/wallet_bloc.dart';
import 'package:kilo/repository/wallet_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:kilo/widgets/show_snack.dart';
import 'package:kilo/widgets/show_dialog.dart';
import 'package:kilo/bloc/bloc.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Colors.orange[400].withOpacity(0.5),
                  shape: CircleBorder(),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orangeAccent.withOpacity(0.9),
                  Colors.orange[400],
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<Object>(
              stream: walletBloc.balanceOut,
              builder: (context, balance) {
                return Text(
                  balance.data==null?
                  "INR 0.00" : "INR ${balance.data}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 55,
                  ),
                );
              }
            ),
                  SizedBox(height: 4),
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Expanded(
                  //   child: new Padding(padding: const EdgeInsets.all(10.0),
                  //   child: Icon(
                  //   Icons.account_balance_wallet_outlined,
                  //   size: 100,

                  // ))),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.orange[400],
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: RaisedButton(
              child: Text(
                'Add Money',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.white,
              color: Colors.orange[400],
              onPressed: () => money(),
            )
          ),
        ],
      ),
    );
  }

  Future money() async {
    var conn = await (Connectivity().checkConnectivity());
    if (conn == ConnectivityResult.none)
      scaffoldKey.currentState.showSnackBar(
          showSnack('No internet connection!', Colors.white, Colors.red[700]));
    else {
      // user = await registerBloc.createLogin();
      if (controller.text == '' || controller.text == ' ') {
        scaffoldKey.currentState.showSnackBar(
            showSnack('Cannot be blank', Colors.white, Colors.red[700]));
      } else
        showDialogBox(context, 'Proceed?', 'Confirm Transaction', addfunds);
    }
  }

  addfunds() async {
    Navigator.of(context).pop();
    bloc.loadingStatusIn.add(true);
    await walletRepo.addMoney(double.parse(controller.text));
    bloc.loadingStatusIn.add(false);
  }
}
