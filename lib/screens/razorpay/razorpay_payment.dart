import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final razorpay = Razorpay();

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);

    super.initState();
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId.toString());
  }

  void paymentError(PaymentFailureResponse response) {
    print(response.message + response.code.toString());
  }

  void externalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  getPayment() {
    var option = {
      'key': 'rzp_test_S6CC9BT4pj4BOK',
      'amount': double.parse(controller.text.trim()) * 100,
      'name': 'Purav',
      'prefill': {'contact': '1234567890', 'email': 'xyz@kilo.com'},
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print('error is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text('Pay'),
              onPressed: () => getPayment(),
            ),
          ]),
    );
  }
}
