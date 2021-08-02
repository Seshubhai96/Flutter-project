import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_application_3/services/Carst%20services.dart';
//import 'package:flutter_application_3/services/Quries.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userorderscreendetails extends StatefulWidget {
  @override
  _UserorderscreendetailsState createState() => _UserorderscreendetailsState();
}

class _UserorderscreendetailsState extends State<Userorderscreendetails> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController shippingaddress = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> orderkey = GlobalKey<FormState>();
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namecontroller.clear();
    email.clear();
    phonenumber.clear();
    shippingaddress.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: orderkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                // Name
                TextFormField(
                  controller: namecontroller,
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Name cant be empty???";
                    }
                    if (value.length < 5) {
                      return "Invalid name";
                    }
                    if (!RegExp("^[A-Z]").hasMatch(value)) {
                      return "Enter only capital letters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.person),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 10, minWidth: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                // shipping address
                TextFormField(
                  controller: shippingaddress,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 4,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Shipping address can be empty!!!";
                    }
                    if (value.length < 20) {
                      return "Not a valid address ?";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Shipping address",
                      labelText: "Shipping address",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.maps_home_work),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 10, minWidth: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      )),
                ),

                SizedBox(
                  height: 10,
                ),
                //phonenumbe
                TextFormField(
                  controller: phonenumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Phonenumber cant be empty";
                    }
                    if (value.length > 10) {
                      return "Not a valid phone number";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      labelText: "Phone",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.phone),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 10, minWidth: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                // email
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email cant be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Enter a valid email eg:- example@gmail.com";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your email",
                      labelText: "email",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.email),
                      prefixIconConstraints:
                          BoxConstraints(minHeight: 10, minWidth: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    getorders();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    height: height * 0.1,
                    width: width * 0.5,
                    child: Text(
                      "Confirm Order",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getorders() async {
    String userid = auth.currentUser.uid.toString();
    final catrproduts = FlutterCart();
    var myproduts = catrproduts.cartItem.map((e) => {
          "id": e.productId,
          "name": e.productName,
          "image": e.uniqueCheck,
          "qty": e.quantity,
          "price": e.unitPrice
        });
    await firestore.collection("orders").doc(userid).set({
      "name": namecontroller.text.toString(),
      "shippingaddress": shippingaddress.text.toString(),
      "email": email.text.toString(),
      "phone": phonenumber.text.toString(),
      "uid": userid.toString(),
      "orderproducts": myproduts.toList(),
    }).then((value) {
      try {
        if (orderkey.currentState.validate()) {
          store();
        }
      } catch (e) {
        throw (e) {
          print("data not fected succfully");
        };
      }

      print(store());
    });
  }

  Future<void> store() async {
    final prfs = await SharedPreferences.getInstance();
    prfs.setString("username", namecontroller.text.toString());
    prfs.setString("Shippingaddress", shippingaddress.text.toString());
    prfs.setString("id", auth.currentUser.uid.toString());
    prfs.setString("phone", phonenumber.text.toString());
  }
}
