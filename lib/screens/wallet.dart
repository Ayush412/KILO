import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/screens/wallet_upi.dart';
import 'package:kilo/screens/wallet_card_info/wallet_card.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 64),
          child: Column(
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
                  ],
                ),
              ),
              SizedBox(height: 32),
              _buildTransactionList(),
            ],
          ),
        ),
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
                _buildTransactionItem(
                  title: "Protein",
                  date: "Today",
                  amount: 780,
                ),
                SizedBox(height: 24),
                _buildTransactionItem(
                  title: "Gym Subscription",
                  date: "Today",
                  amount: 9800,
                ),
                SizedBox(height: 24),
                _buildTransactionItem(
                  title: "Energy Bars",
                  date: "Yesterday",
                  amount: 520,
                ),
                SizedBox(height: 24),
                _buildTransactionItem(
                  title: "Orange Juice",
                  date: "Yesterday",
                  amount: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildCategories() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
                    color: Colors.deepOrange,
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
              navigate(context, Wallet_UPI(),
                  PageTransitionAnimation.slideRight, false);
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
                    color: Colors.deepOrange,
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
              navigate(context, WalletCard(),
                  PageTransitionAnimation.slideRight, false);
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
                    color: Colors.deepOrange,
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
                    color: Colors.deepOrange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Offers",
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
        ]);
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.deepOrange,
    //   iconData: Icons.work,
    //   text: "Activities",
    // ),
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.deepOrange,
    //   iconData: Icons.trending_up,
    //   text: "Stats",
    // ),
    // _buildCategoryCard(
    //   bgColor: Colors.black,
    //   iconColor: Colors.deepOrange,
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
            Colors.deepOrange,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "INR 0.00",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Total Balance",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
              ),
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
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${loginBloc.userMap['Name']}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
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
              colorFilter: ColorFilter.mode(
                Colors.deepPurple[100],
                BlendMode.darken,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildTransactionItem(
      {
        String date,
        String title,
        double amount,
      }
        ) 
        {
        return Row(
        children: <Widget>[
        Container(
          height: 10,
          width: 20,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
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
