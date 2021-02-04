import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kilo/repository/user_data_repo.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/sharedpref.dart';

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
      await userDataRepo.getUserData(emailID);
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
    await userDataRepo.getUserData(_user.email);
  }

  googleLogout() async{
    await _googleSignIn.signOut();
  }

  normalLogout() async{
    await FirebaseAuth.instance.signOut();
  }
}

final userRegisterRepo = UserRegisterRepo();