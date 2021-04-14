import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/bloc/wallet_bloc.dart';
import 'package:kilo/screens/purchase.dart';
import 'package:kilo/widgets/circular_progress.dart';
import 'package:kilo/widgets/ordersCard.dart';
import 'package:kilo/screens/add_money.dart';
import 'package:kilo/screens/razorpay/razorpay_payment.dart';
import 'package:kilo/screens/wallet_upi.dart';
import 'package:kilo/screens/wallet_card_info/wallet_card.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  onRefresh() async {
    bloc.loadingStatusIn.add(true);
    await walletBloc.getBalance();
    await walletBloc.getOrders();
    bloc.loadingStatusIn.add(false);
  }

  @override
  void initState() {
    super.initState();
    walletBloc.getBalance();
    walletBloc.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: underlineText('Wallet', 24, Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => onRefresh(),
              color: Colors.grey[800],
              splashColor: Colors.orange[400],
              splashRadius: 15)
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      _buildHeader(),
                      SizedBox(height: 16),
                      _buildGradientBalanceCard(),
                      SizedBox(height: 24.0),
                      _buildCategories(),
                      SizedBox(height: 24.0),
                      RaisedButton(
                        color: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.orange[400],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Store",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          navigate(context, PurchaseItem(),
                              PageTransitionAnimation.slideRight, false);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                //_buildTransactionList(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Transaction History:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: StreamBuilder(
                        stream: walletBloc.transactionsOut,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> orders) {
                          if (!orders.hasData)
                            return Center(child: CircularProgressIndicator());
                          else {
                            if (orders.data.docs.length == 0)
                              return Center(
                                  child: Column(children: [
                                Image.asset('assets/search.png', height: 80),
                                Text("No Transactions"),
                              ]));
                            else
                              return ListView.builder(
                                  itemCount: orders.data.docs.length,
                                  itemBuilder: (_, index) {
                                    return ordersCard(
                                        context, orders.data.docs[index]);
                                  });
                          }
                        }))
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: circularProgressIndicator(context))
        ]),
      ),
    );
  }

  Container _buildTransactionList() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.1),
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0 * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Transaction",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildCategories() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
        Widget>[
      RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.send,
                color: Colors.orange[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "UPI",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          navigate(
              context, wallet_UPI(), PageTransitionAnimation.slideRight, false);
        },
      ),
      RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.payment,
                color: Colors.orange[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "Card",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          navigate(
              context, WalletCard(), PageTransitionAnimation.slideRight, false);
        },
      ),
      RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.trending_up,
                color: Colors.orange[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "History",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          // navigate(context, Wallet_UPI(),
          //     PageTransitionAnimation.slideRight, false);
        },
      ),
      RaisedButton(
        color: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.local_offer,
                color: Colors.orange[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "RazorPay",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          navigate(
              context, Payment(), PageTransitionAnimation.slideRight, false);
        },
      ),
    ]);
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.orange[400],
    //   iconData: Icons.work,
    //   text: "Activities",
    // ),
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.orange[400],
    //   iconData: Icons.trending_up,
    //   text: "Stats",
    // ),
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.orange[400],
    //   iconData: Icons.payment,
    //   text: "History",
    // ),
    // ],
    // );
  }

  Container _buildGradientBalanceCard() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<Object>(
              stream: walletBloc.balanceOut,
              builder: (context, balance) {
                return Text(
                  balance.data==null?
                  "INR 0.00" : "INR ${balance.data}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                );
              }
            ),
            // Expanded(

            // child: Padding(
            //   padding: EdgeInsets.symmetric(),
            //   child: Text(
            //   "Total Balance",
            //   style: TextStyle(
            //     color: Colors.white.withOpacity(0.9),
            //     fontSize: 18,
            //   ),
            // ),),),
            RaisedButton(
              color: Colors.black,
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.orange[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "ADD MONEY",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                navigate(context, AddMoney(),
                    PageTransitionAnimation.slideRight, false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              greeting(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${loginBloc.userMap['Name']}",
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage("assets/KILO_Logo.jpg"),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildTransactionItem({
    String date,
    String title,
    double amount,
  }) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 20,
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              date,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )
          ],
        ),
        Spacer(),
        Text(
          "INR $amount",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    }
    if (hour < 17) {
      return 'Good Afternoon,';
    }
    return 'Good Evening,';
  }
}
