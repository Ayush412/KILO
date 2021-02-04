import 'package:flutter/material.dart';
import 'login.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/navigate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Home Screen...'),),
      ),
    );
  }
}