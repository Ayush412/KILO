import 'dart:async';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:email_validator/email_validator.dart';

mixin ValidateCredentials {
  var emailValidator =
    StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final bool isValid = EmailValidator.validate(email);
    if (!isValid)
      sink.addError("Invalid email");
    else
      sink.add(email);
    loginBloc.emailID = email;
  });

  var passValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password == null || password == '')
      sink.addError("Must be provided");
    else
      sink.add(password);
    loginBloc.pass = password;
  });

  getdata() {}
}
