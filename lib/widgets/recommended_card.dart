import 'package:flutter/material.dart';

recommendedCard(BuildContext context, int duration, String image){
  Size size = MediaQuery.of(context).size;
  return Container(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Recommended',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$duration mins',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.9),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
    ),
    width: size.width - 40,
    height: (size.width - 10) / 2,
    margin: EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      color: Colors.white70,
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 25.0,
          offset: Offset(8.0, 8.0),
        ),
      ],
    ),
  );
}