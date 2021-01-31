import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';

circularProgressIndicator(BuildContext context){
  return StreamBuilder(
    stream: bloc.loadingStatusOut,
    builder: (context, snapshot){
      if(snapshot.hasData && snapshot.data==true)
        return Container(
          height: 25, width: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[400])
          )
        );
      else if(!snapshot.hasData || snapshot.data==false)
        return SizedBox(height: 30, width: 30);
    },
  );
}
