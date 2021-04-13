import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ordersCard(BuildContext context, DocumentSnapshot order){
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(children: [
            Text('Order No :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
            Padding(padding: const EdgeInsets.only(left: 10),
            child: Text(order.id, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(children: [
              Text('Amount :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
              Padding(padding: const EdgeInsets.only(left: 10),
              child: Text('QR. ${order.data()['Total']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey))
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
              Text('Date :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
              Padding(padding: const EdgeInsets.only(left: 10),
              child: Text(order.data()['Date'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey))
              ),
            ]),
          ),
        ])
      ),
    ),
  );
}