import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Online_task/dropdownservices.dart';
import 'package:flutter_application_3/onlineprojecttask2/booking.dart';
class Fetchdatascreen extends StatefulWidget {


  @override
  _FetchdatascreenState createState() => _FetchdatascreenState();
}

class _FetchdatascreenState extends State<Fetchdatascreen> {
  GlobalKey<FormState> buskey =GlobalKey<FormState>();
  TextEditingController busname =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
              key: buskey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: busname,
                  keyboardType: TextInputType.name,

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
                    hintText: "Enter Bus name",
                    labelText: "Busname",
                    prefixIcon: Icon(Icons.motorcycle),
                    border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                  ),
                ),
              ),
            ),
            DropdownButton(
              hint: Text('origin',style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),),
              value: NewDropdown.selectorigin,
              items: NewDropdown.fromroute.map((o)  {
                return DropdownMenuItem(
                  value: o,
                  child: Text(o),
                );
              }).toList(),
              onChanged: (o){
                setState(() {
                  NewDropdown.selectorigin=o;
                });
              },
            ),
            DropdownButton(
              hint: Text('destination',style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),),
              value: NewDropdown.selectedestination,
              items: NewDropdown.toroute.map((d)  {
                return DropdownMenuItem(
                  value: d,
                  child: Text(d),
                );
              }).toList(),
              onChanged: (d){
                setState(() {
                  NewDropdown.selectedestination=d;
                });
              },
            ),
            DropdownButton(
              hint: Text('Select time slot',style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),),
              value: NewDropdown.selecttime,
              items: NewDropdown.deperturetime.map((t)  {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t),
                );
              }).toList(),
              onChanged: (t){
                setState(() {
                  NewDropdown.selecttime=t;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
              setdata();
              },
              child: Text('submit'),
            )

          ],
        ),
      ),
    );
  }
  Future<void> setdata()async{
    //navigation?
  if (buskey.currentState.validate()) {
      FirebaseFirestore.instance.collection("Busservices").doc().set({

       "busname":busname.text.toString(),
       "origin":NewDropdown.selectorigin.toString(),
       "destination":NewDropdown.selectedestination.toString(),
       "bustiming":NewDropdown.selecttime.toString(),
     }
     ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>Availbilityscreen())));
  }
   }
}


