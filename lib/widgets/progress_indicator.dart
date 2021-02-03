import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:flutter/material.dart';

progressIndicator(BuildContext context){
  return StreamBuilder(
    stream: bloc.loadingStatusOut,
    builder: (context, snapshot){
      if(snapshot.hasData && snapshot.data==true)
        return SpinKitFoldingCube(size: 30, color: Colors.orange[400]);
      else if(!snapshot.hasData || snapshot.data==false)
        return SizedBox(height: 30, width: 30);
    }
  );
}