import 'package:flutter/material.dart';
import 'package:flutter_application_3/controllers/Editing_controller.dart';
import 'package:flutter_application_3/services/Auth_srvices.dart';

class Forgotpasswordscreen extends StatefulWidget {
  @override
  _ForgotpasswordscreenState createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.amberAccent,
          child: Column(
            children: [
              Card(
                child: TextFormField(
                  key: _formkey,
                  controller: MyEditingcontroller.emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email can't be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        .hasMatch(value)) {
                      return "please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState.validate()) {
                    MyDatabaseservices.forgotpassword(context);
                  }
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Center(
                    child: Text(
                      'PasswordResetlink',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
