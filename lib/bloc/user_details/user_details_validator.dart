import 'dart:async';
import 'user_details_bloc.dart';

mixin ValidateDetails{

  var nameValidator = StreamTransformer<String , String>.fromHandlers(
    handleData: (name, sink){
      if(name=='' || name==null)
        sink.addError("Required");
      else
        sink.add(name); 
      userDetailsBloc.name = name;
    }
  );

  var ageValidator = StreamTransformer<String , String>.fromHandlers(
    handleData: (age, sink){
      if(age=='' || age==null)
        sink.addError("Required");
      else
        sink.add(age);
      userDetailsBloc.age = age;
    }
  );

  var heightValidator = StreamTransformer<String , String>.fromHandlers(
    handleData: (height, sink){
      if(height=='' || height==null)
        sink.addError("Required");
      else
        sink.add(height);
      userDetailsBloc.height = height;
      userDetailsBloc.getBMI();
    }
  );


  var weightValidator = StreamTransformer<String , String>.fromHandlers(
    handleData: (weight, sink){
      if(weight=='' || weight==null)
        sink.addError("Required");
      else
        sink.add(weight);
      userDetailsBloc.weight = weight;
      userDetailsBloc.getBMI();
    }
  );
}