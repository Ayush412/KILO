import 'package:flutter/material.dart';
import 'package:kilo/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ordersCard(BuildContext context, DocumentSnapshot order){
  List<String> keys = order.data['Status Dates'].keys.toList();
  int status = keys.length-1;
  List statuses = ['Order Confirmed', 'Packed', 'Shipped', 'Delivered'];
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
    child: InkWell(
      onTap: () => navigate(context, OrderTracking(order: order)),
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
              child: Text(order.documentID, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(children: [
                Text('Amount :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
                Padding(padding: const EdgeInsets.only(left: 10),
                child: Text('QR. ${order.data['Total']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey))
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                Text('Date :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),
                Padding(padding: const EdgeInsets.only(left: 10),
                child: Text(order.data['Date'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey))
                ),
                Container(
                  width: 180,
                  child: Text(statuses[status], 
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,
                      color: statuses[status]=='Delivered'? Colors.green : Colors.blue[400]
                  )),
                ),
              ]),
            ),
          ])
        ),
      ),
    )
  );
}