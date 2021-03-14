import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kilo/bloc/login/login_bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/screens/login.dart';
import 'package:kilo/sharedpref.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:page_transition/page_transition.dart';

class UserRegisterRepo{

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  createLogin(String emailID, String pass) async{
    UserCredential new_user;
    try{
      new_user = await _auth.createUserWithEmailAndPassword(email: emailID, password: pass);
    }catch(e){print(e);}
    if(new_user!=null){
      await new_user.user.sendEmailVerification();
      return true;
    }
    else{ 
      print('already exists');
      return false;
    }
  }

  checkLogin(String emailID, String pass) async{
    UserCredential user;
    try{
      user = await _auth.signInWithEmailAndPassword(email: emailID, password: pass);
    }catch(e){print('Not found.');}
    if (user==null || !user.user.emailVerified){
      return false;
    }
    else{
      loginBloc.emailID = emailID;
      await userDataRepo.getUserData(emailID, true);
      return true;
    }
  }

  googleLogin() async{
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    bloc.loadingStatusIn.add(true);
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User _user = userCredential.user;
    assert(!_user.isAnonymous);
    print("Name: ${_user.displayName}, Email: ${_user.email}");
    loginBloc.emailID = _user.email;
    await userDataRepo.getUserData(_user.email, true);
  }

  logOut(BuildContext context) async{
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    sharedPreference.removeData();
    sharedPreference.resetSteps();
    sharedPreference.setGFitAccess(null);
    sharedPreference.resetCals();
    navigate(context, Login(), PageTransitionAnimation.fade, false);
  }
}

final userRegisterRepo = UserRegisterRepo();