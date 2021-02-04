import 'dart:async';
import 'register_bloc.dart';

mixin ValidateCredentials{

  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if (email.contains("@") && email.contains("."))
        sink.add(email);
      else
        sink.addError("Invalid email");
      registerBloc.emailID = email;
    }
  );

  var pass1Validator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password1, sink){
      if (password1.length>7)
        sink.add(password1);
      else
        sink.addError("Must be at least 8 characters long");
      registerBloc.pass = password1;
    }
  );

  var pass2Validator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password2, sink){
      if (password2==registerBloc.pass)
        sink.add(password2);
      else
        sink.addError("Passwords don't match");
    }
  );
}