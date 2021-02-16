import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kilo/widgets/underline_text.dart';
import 'package:kilo/screens/programs.dart';


class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Programs(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
