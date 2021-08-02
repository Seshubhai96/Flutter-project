import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/controllers/Editing_controller.dart';
import 'package:flutter_application_3/models/usermodel.dart';
import 'package:flutter_application_3/views/project_auth_views/Login_screen.dart';
import 'package:flutter_application_3/views/project_views/Home.dart';

class MyDatabaseservices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static getsignup(String email, String password, context) async {
    String email = MyEditingcontroller.emailcontroller.text.toString();
    String password = MyEditingcontroller.passwordcontroller.text.toString();
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => Homescreen()), (route) => false);
      postdata();
    });
  }

  static postdata() {
    Usermodel usermodel = Usermodel();
    usermodel.uid = auth.currentUser.uid.toString();
    usermodel.username = MyEditingcontroller.namecontroller.text.toString();
    usermodel.useremail = MyEditingcontroller.emailcontroller.text.toString();
    usermodel.userphone =
        MyEditingcontroller.phonenumbercontroller.text.toString();
    usermodel.useraddress =
        MyEditingcontroller.addresscontroller.text.toString();
    firestore.collection('Userdata').doc(usermodel.uid).set(usermodel.toMap());
  }

  static signin(context) {
    auth
        .signInWithEmailAndPassword(
            email: MyEditingcontroller.emailcontroller.text.toString(),
            password: MyEditingcontroller.passwordcontroller.text.toString())
        .then((value) => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => Homescreen()),
                  (route) => false)
            });
  }

  static forgotpassword(context) {
    auth
        .sendPasswordResetEmail(
            email: MyEditingcontroller.emailcontroller.text.toString())
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Loginscreen()));
    });
  }

  static signout(context) {
    auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => Loginscreen()), (route) => false);
    });
  }
}
