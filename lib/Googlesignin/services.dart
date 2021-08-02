

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi extends ChangeNotifier{
 final googlesignin =GoogleSignIn();
 GoogleSignInAccount _user;
 GoogleSignInAccount get user=>_user;

 Future<void> googlelogin()async{
   var  googleuser=await googlesignin.signIn();
   if(googleuser == null){
     return googleuser=user;
   }
   final googleauth= await googleuser.authentication;
   final credencials = GoogleAuthProvider.credential(
     accessToken: googleauth.accessToken,
     idToken:  googleauth.idToken,
   );
   await FirebaseAuth.instance.signInWithCredential(credencials);
   notifyListeners();
 }
 Future Logout()async{
   await googlesignin.disconnect();
   FirebaseAuth.instance.signOut();

 }
}