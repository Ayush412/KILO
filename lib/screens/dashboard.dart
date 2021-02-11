import 'package:flutter/material.dart';
import 'package:kilo/widgets/underline_text.dart';

class Dahsboard extends StatefulWidget {
  @override
  _DahsboardState createState() => _DahsboardState();
}

class _DahsboardState extends State<Dahsboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: underlineText('Dashboard', 21, Colors.black), 
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}