import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

productCard(BuildContext context, DocumentSnapshot product, dynamic purchase){
  return Card(
    elevation: 2.2,
    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: Stack(
      children: [
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(child: Image.network(product.data()['Image'], height: 100, width: 100)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Container(
                height: 50,
                child: Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(product.data()['Name'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  )
                ),
              ),
            ),
            Align(alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text('Rs. ${product.data()['Price']}', 
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w700,
                    color: Colors.green
                  )
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: ElevatedButton(
                onPressed: () => purchase(product),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text('BUY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            )
          ]
        ),
      ]
    )
  );
}