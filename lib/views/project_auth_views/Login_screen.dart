import 'dart:ui';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/Googlesignin/services.dart';
import 'package:flutter_application_3/controllers/Editing_controller.dart';
import 'package:flutter_application_3/services/Auth_srvices.dart';
import 'package:flutter_application_3/views/project_auth_views/Forgetpassword_screen.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_application_3/views/project_auth_views/Signup_screen.dart';
//import 'package:flutter_application_3/views/project_views/Home.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
   // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Container(
                height:height*0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/Category%2Ffreestocks-_3Q3tsJ01nc-unsplash.jpg?alt=media&token=6ea53652-7e88-41cb-9e27-996a1f63167e'),
                    colorFilter: ColorFilter.mode(
                        Colors.orange.withOpacity(0.65), BlendMode.modulate),
                    fit: BoxFit.fill,
                  ),
                ),),
              Container(
                height:500 ,
                decoration: BoxDecoration(
                  //gradient: LinearGradient(colors: [Colors.yellow,Colors.purple]),
                  //borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text('LOGIN',style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),textAlign: TextAlign.center,),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text('Signup',style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.blue[900]),textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            // email
                            TextFormField(
                              controller: MyEditingcontroller.emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters:<TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email Can not be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                              .hasMatch(value)) {
                            return "please enter a valid email";
                          } else {
                            return null;
                          }
                        }, decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: Icon(Icons.mail),
                              suffixStyle: TextStyle(color: Colors.black),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              hintText: 'Enter Email',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            // password
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: (){}, child: Text('Forgot password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
                            ),
                            SizedBox(height: 25,),
                            Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),

                              child: Text('LOGIN',style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white,),textAlign: TextAlign.center,),
                            ),
                            SizedBox(height: 30,),
                            Text("OR",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    final provider = Provider.of<GoogleSignInApi>(context,listen: false);
                                    provider.googlelogin();
                                  },
                                  child: SizedBox(
                                      height: 50,
                                      child: Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/download.png?alt=media&token=cd86ede9-1cd1-4de2-af7d-653df555d585')),
                                ),
                                SizedBox(width: 15,),
                                InkWell(
                                  onTap: (){},
                                  child: SizedBox(
                                      height: 40,
                                      child: Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/download%20(1).png?alt=media&token=cbaa5e6b-7e2a-40e0-9e1b-39c8f6cc4032')),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (_,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasError){
                    return Text('Something went wrong');
                  }
                  if(snapshot.hasData){
                    return DrawerHeader(child: ListTile(
                      leading:  CircleAvatar(backgroundImage: NetworkImage(user.photoURL),child: IconButton(
                        icon: Icon(Icons.upload_outlined),
                        splashColor: Colors.deepPurple,
                        color: Colors.black,
                        onPressed: (){},
                      ),),
                    ));
                  }

                },
              )
            ],
          ),
        ],
      ),
    );
  }


  }




//Container(
//         decoration: BoxDecoration(
//             gradient:
//                 LinearGradient(colors: [Colors.purpleAccent, Colors.pink])),
//         height: height * 1,
//         width: width * 1,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Card(
//               color: Colors.transparent,
//               child: Form(
//                 key: _formkey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Material(
//                       textStyle: TextStyle(color: Colors.white),
//                       shadowColor: Colors.black,
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       child: TextFormField(
//                         controller: MyEditingcontroller.emailcontroller,
//                         keyboardType: TextInputType.emailAddress,
//                         style: TextStyle(color: Colors.white),
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return "Email Can not be empty";
//                           }
//                           if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
//                               .hasMatch(value)) {
//                             return "please enter a valid email";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Email",
//                           hintStyle: TextStyle(color: Colors.white),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Material(
//                       textStyle: TextStyle(color: Colors.white),
//                       shadowColor: Colors.black,
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       child: TextFormField(
//                         controller: MyEditingcontroller.passwordcontroller,
//                         keyboardType: TextInputType.visiblePassword,
//                         style: TextStyle(color: Colors.white),
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return "password Can not be empty";
//                           }
//                           if (value.length < 6) {
//                             return "please enter a valid password";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           hintStyle: TextStyle(color: Colors.white),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           try {
//                             if (_formkey.currentState.validate()) {
//                               MyDatabaseservices.signin(context);
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text('welcome to app'),
//                                 elevation: 5,
//                                 behavior: SnackBarBehavior.floating,
//                                 shape: ContinuousRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(50))),
//                               ));
//                             } else {
//                               return {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content: Text('Wrongusername/password'),
//                                   elevation: 5,
//                                   behavior: SnackBarBehavior.floating,
//                                   action: SnackBarAction(
//                                     label: 'Forgot password',
//                                     onPressed: () {
//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) =>
//                                                   Forgotpasswordscreen()),
//                                           (route) => false);
//                                     },
//                                     textColor: Colors.black,
//                                   ),
//                                   shape: ContinuousRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(50))),
//                                 ))
//                               };
//                             }
//                           } catch (e) {
//                             print(e.toString());
//                             // ignore: await_only_futures
//
//                           }
//                         },
//                         child: Text("Login"))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),