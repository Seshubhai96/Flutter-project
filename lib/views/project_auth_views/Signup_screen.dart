import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_3/controllers/Editing_controller.dart';
import 'package:flutter_application_3/services/Auth_srvices.dart';
import 'package:flutter_application_3/views/project_auth_views/Login_screen.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.indigoAccent,
            Colors.yellowAccent,
            Colors.pinkAccent
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/index.jpg?alt=media&token=6841d60a-ed05-4044-85f0-903eca6977a4'),
                            maxRadius: 40,
                          ),
                          TextFormField(
                            controller: MyEditingcontroller.namecontroller,
                            keyboardType: TextInputType.name,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name can't be empty";
                              }
                              if (value.length < 6) {
                                return "Enter valid name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: InputBorder.none,
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                hintText: "Enter your Name !!!",
                                prefixIcon: Icon(Icons.person),
                                prefixStyle: TextStyle(
                                    backgroundColor: Colors.blue,
                                    color: Colors.deepPurpleAccent),
                                hintStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20))),
                                )),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Colors.black,
                          ),
                          TextFormField(
                            controller: MyEditingcontroller.emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email Can not be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: InputBorder.none,
                                labelText: 'Email Address',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                hintText: "Enter your Email !!!",
                                prefixIcon: Icon(Icons.mail),
                                prefixStyle: TextStyle(
                                    backgroundColor: Colors.blue,
                                    color: Colors.deepPurpleAccent),
                                hintStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20))),
                                )),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Colors.black,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: MyEditingcontroller.passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "password Can not be empty";
                              }
                              if (value.length < 6) {
                                return "please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: InputBorder.none,
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                hintText: "Enter your Password !!!",
                                prefixIcon: Icon(Icons.remove_red_eye_outlined),
                                prefixStyle: TextStyle(
                                    backgroundColor: Colors.blue,
                                    color: Colors.deepPurpleAccent),
                                hintStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20))),
                                )),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Colors.black,
                          ),
                          TextFormField(
                            controller:
                                MyEditingcontroller.phonenumbercontroller,
                            keyboardType: TextInputType.phone,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "phonenumber Can not be empty";
                              }
                              if (value.length < 9) {
                                return "please enter a valid phonenumber";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: InputBorder.none,
                                labelText: 'Phonenumber',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                hintText: "Enter your Phonenumber !!!",
                                prefixIcon: Icon(Icons.phone_android),
                                prefixStyle: TextStyle(
                                    backgroundColor: Colors.blue,
                                    color: Colors.deepPurpleAccent),
                                hintStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20))),
                                )),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Colors.black,
                          ),
                          TextFormField(
                            controller: MyEditingcontroller.addresscontroller,
                            keyboardType: TextInputType.streetAddress,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Address Can not be empty";
                              }
                              if (value.length < 8) {
                                return "please enter a valid Address";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: InputBorder.none,
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                hintText: "Enter your Address !!!",
                                prefixIcon: Icon(Icons.map),
                                prefixStyle: TextStyle(
                                    backgroundColor: Colors.blue,
                                    color: Colors.deepPurpleAccent),
                                hintStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20))),
                                )),
                          ),
                          Divider(
                            height: 10,
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formkey.currentState.validate()) {
                                String email = MyEditingcontroller
                                    .emailcontroller.text
                                    .toString();
                                String password = MyEditingcontroller
                                    .passwordcontroller.text
                                    .toString();
                                MyDatabaseservices.getsignup(
                                    email, password, context);
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 250,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blueAccent,
                                        Colors.orangeAccent
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20)))),
                              child: Center(
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Loginscreen()));
                            },
                            child: Container(
                              height: 40,
                              width: 250,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blueAccent,
                                        Colors.orangeAccent
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: (Radius.circular(20)))),
                              child: Center(
                                child: Text(
                                  'Already user go to Loginscreen',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(child: Text('Google')),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(child: Text('Facebook')),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
