import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

textField(Stream stream, Function onChanged, String hintText, Icon icon, TextInputType keyboard, bool obscure, bool digitsOnly) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) => Theme(
      data: ThemeData(
        accentColor: Colors.orange[400], brightness: Brightness.dark),
      child: TextField(
        keyboardType: keyboard,
        onChanged: onChanged,
        obscureText: obscure,
        style: TextStyle(color: Colors.black),
        inputFormatters: digitsOnly? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          icon: icon,
          errorText: snapshot.error,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    )
  );
}