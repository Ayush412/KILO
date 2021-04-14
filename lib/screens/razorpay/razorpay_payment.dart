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
      backgroundColor: Colors.white,
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
            SizedBox(height: 50),
            TextField(
              controller: controller,
              cursorColor: Colors.orange[400],
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text(
                'Pay',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.white,
              color: Colors.orange[400],
              onPressed: () => getPayment(),
            ),
          ]),
    );
  }
}
