import 'package:flutter/material.dart';
import 'package:kilo/screens/wallet.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 35),
              controller: controller,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text('Add Money'),
              color: Colors.black12,
              onPressed: () => addMoney(),
            ),
          ]),
    );
  }

  addMoney() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(
              "Added INR " + controller.text + " to Wallet\n New Amount = "),
        );
      },
    );
  }
}
