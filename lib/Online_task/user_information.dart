import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/Online_task/dropdownservices.dart';
import 'package:flutter_application_3/Online_task/userscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Userinformation extends StatefulWidget {


  @override
  _UserinformationState createState() => _UserinformationState();
}

class _UserinformationState extends State<Userinformation> {
  final TextEditingController personname = TextEditingController();

  GlobalKey<FormState> _useracesskey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User vaccine'),
      actions: [
        Icon(Icons.info),
      ],
      ),
      body:Form(
        key: _useracesskey,
        child:Column(
          children: [
            //user/personname
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: personname,
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                validator: (name){
                  if(name.isEmpty){
                    return "Name cant be empty";
                  }
                  // if(!RegExp("^[AZ]").hasMatch(name)){
                  //   return "Enter a valid name";
                  // }
                  else
                    {
                      return null;
                    }
                },
                decoration: InputDecoration(
                  hintText: "Enter Your name",
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                ),
              ),
            ),
            SizedBox(height: 10,),
            //userlocation
            Center(
              child: Container(
                child: DropdownButton(
                  value:Dropdownservices.selectloc,
                  items: Dropdownservices.location.map((city)  {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (city){
                    setState(() {
                      Dropdownservices.selectloc=city;
                    });

                  },
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                //dose
                child: DropdownButton(
                  value:Dropdownservices.selectdose.toString(),
                  items:Dropdownservices.dose .map((Typedose)  {
                    return DropdownMenuItem(
                      value: Typedose,
                      child: Text(Typedose),
                    );
                  }).toList(),
                  onChanged: (Typedose){
                    setState(() {
                      Dropdownservices.selectdose=Typedose;
                    });

                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Container(
                // type
                child: DropdownButton(
                  value:Dropdownservices.selectype,
                  items: Dropdownservices.type.map((Dosename)  {
                    return DropdownMenuItem(
                      value: Dosename,
                      child: Text(Dosename),
                    );
                  }).toList(),
                 onChanged: (Dosename){
                    setState(() {
                      Dropdownservices.selectype=Dosename;
                    });

                 },
                ),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              if(_useracesskey.currentState.validate()){
                setuserdata().then((value) => {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Userscreen())),
                });
              }
            }, child: Text('submit')),
          ],
        ) ,
      ),

    );
  }
  Future<void> setuserdata()async{

    await FirebaseFirestore.instance.collection("orders").doc().set({
      "personname":personname.text.toString(),
      "location":Dropdownservices.selectloc.toString(),
      "dosetype":Dropdownservices.selectdose.toString(),
      "vaccinetype":Dropdownservices.selectype.toString(),


    }).then((value) {
      store();
    });


  }
  Future<void> store() async {
    final prfs = await SharedPreferences.getInstance();
    prfs.setString("personname", personname.text.toString());
    prfs.setString("location", Dropdownservices.selectloc.toString());
    prfs.setString("dose", Dropdownservices.selectdose.toString());
    prfs.setString("type", Dropdownservices.selectype.toString());
  }

}
