import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Googlesignin/services.dart';
import 'package:flutter_application_3/Online_task/user_information.dart';
import 'package:flutter_application_3/onlineprojecttask2/Fetchdata.dart';

import 'package:flutter_application_3/views/project_auth_views/Login_screen.dart';
import 'package:flutter_application_3/views/project_auth_views/Signup_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';



//import 'views/project_auth_views/Signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInApi(),
      child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: Fetchdatascreen()),
    );
  }
}
