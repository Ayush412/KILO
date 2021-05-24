import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/bloc/products_bloc.dart';
import 'package:kilo/repository/wallet_repo.dart';
import 'package:kilo/screensize.dart';
import 'package:kilo/widgets/circular_progress.dart';
import 'package:kilo/widgets/product_card.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:kilo/widgets/show_snack.dart';
import 'package:kilo/widgets/show_dialog.dart';


class PurchaseItem extends StatefulWidget {
  @override
  _PurchaseItemState createState() => _PurchaseItemState();
}

class _PurchaseItemState extends State<PurchaseItem> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DocumentSnapshot product;

  confirmPurchase(DocumentSnapshot item) async{
    var conn = await (Connectivity().checkConnectivity());
    if (conn == ConnectivityResult.none)
      scaffoldKey.currentState.showSnackBar(
          showSnack('No internet connection!', Colors.white, Colors.red[700]));
    else {
      product = item;
      double balance = (await walletRepo.getbalance()).toDouble();
      if (balance < product.data()['Price']) {
        scaffoldKey.currentState.showSnackBar(
            showSnack('Insufficient funds', Colors.white, Colors.orange[400]));
      } else
        showDialogBox(context, 'Proceed?', 'Confirm Purchase', purchase);
    }
  }

  purchase() async {
    Navigator.of(context).pop();
    bloc.loadingStatusIn.add(true);
    await walletRepo.spendMoney((product.data()['Price']).toDouble(), product.data()['Name'], product.data()['Image']);
    bloc.loadingStatusIn.add(false);
  }

  @override
  void initState() {
    productsBloc.productsIn.add(null);
    productsBloc.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: underlineText('Store', 24, Colors.black), 
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        actions: [Container(
          height: 10,
          child: Center(child: circularProgressIndicator(context)))
        ]
        ),
        body: StreamBuilder(
          stream: productsBloc.productsOut,
          builder: (context, products) {
            if(!products.hasData)
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[400])),
                ),
              );
            else
              return Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: GridView.builder(
                  itemCount: products.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: screenSize(180, context)/screenSize(250, context)
                  ),
                  itemBuilder: (context, index) => Card(
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: productCard(context, products.data[index], confirmPurchase)
                  )
                ),
              );  
          },
        )
      ),
    );
  }
}