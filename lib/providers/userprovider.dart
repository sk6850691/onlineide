import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



enum Status{Uninitialized,Authenticated,Unauthenticated,Authenticating}

class UserProvider extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  User user;




  Map cartitem;

 void saveuid(uidi)async{

    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.setString('uid',uidi);
  }
  getuid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   return  prefs.get('uid');


  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,

    );

    // ignore: missing_return
    return await auth.signInWithCredential(credential).then((value) {
      saveuid(value.user.uid);
      print(value.user.uid);
      FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
        "id": value.user.uid,
        "name": value.user.displayName,
        "email": value.user.email
      });
    });
  }


  Status status = Status.Uninitialized;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController phoneController = TextEditingController();


  UserProvider.intialize():auth = FirebaseAuth.instance{
    //auth.authStateChanges().listen()
  }

  googleSignOut() {
    auth.signOut();
  }

  signin() {


  }

  signUp() {
    auth.signInWithPhoneNumber(phoneController.text, RecaptchaVerifier(

        container: 'rewcaptcha',
        size: RecaptchaVerifierSize.compact,
        theme: RecaptchaVerifierTheme.dark
    ));
  }


}






