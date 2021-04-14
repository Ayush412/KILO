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
      
      backgroundColor: Colors.white,
      
      body: 
      Column(
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
              )
            ),
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
                  Text(
                    "INR 0.00",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 55,
                    ),
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
                  
                  
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: 
                        TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        
                        cursorColor: Colors.orange[400],
                        controller: controller,
                        keyboardType: TextInputType.number,
                  ),
                  ),),
                  
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(125),
                      child: RaisedButton(
                        child: Text('Add Money',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Colors.orange[400],
                        onPressed: () => addMoney(),
                    )            
                    
                  ),
                  ),
          ],
          ),
          );
  }

  addMoney() {
    return showDialog(
      barrierColor: Colors.grey,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.orange[400],
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(
              "Added INR " + controller.text + " to Wallet\n\nNew Amount = ",
              style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            
                            
                          ),),
        );
      },
    );
  }
}
