import 'package:flutter/material.dart';

textField(Stream stream, Function onChanged, String hintText, String labelText, Icon icon, TextInputType keyboard, bool obscure) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) => Theme(
      data: ThemeData(primaryColor: Colors.orange[400]),
      child: TextField(
        keyboardType: keyboard,
        onChanged: onChanged,
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          errorText: snapshot.error,
          //labelText: labelText,
          //prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    )
  );
}