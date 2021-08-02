import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/Online_task/dropdownservices.dart';

class Availbilityscreen extends StatefulWidget {


  @override
  _AvailbilityscreenState createState() => _AvailbilityscreenState();
}

class _AvailbilityscreenState extends State<Availbilityscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: DropdownButton(
              hint: Text('origin',style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),),
              value: NewDropdown.selectorigin,
              items: NewDropdown.fromroute.map((o) {
                return DropdownMenuItem(
                  value: o,
                  child: Text(o),
                );
              }).toList(),
              onChanged: (o) {
                setState(() {
                  NewDropdown.selectorigin = o;
                });
              },
            ),
          ),
          Center(
            child: DropdownButton(
              hint: Text('destination',style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),),
              value: NewDropdown.selectedestination,
              items: NewDropdown.toroute.map((d) {
                return DropdownMenuItem(
                  value: d,
                  child: Text(d),
                );
              }).toList(),
              onChanged: (d) {
                setState(() {
                  NewDropdown.selectedestination = d;
                });
              },
            ),
          ),
          Center(
            child: DropdownButton(
              hint: Text('Time slot for booking ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              value: NewDropdown.selecttime,
              items: NewDropdown.deperturetime.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t),
                );
              }).toList(),
              onChanged: (t) {
                setState(() {
                  NewDropdown.selecttime = t;

                });
              },
            ),
          ),
          Center(
            child: ElevatedButton(
                child: Text('clik here'),
                onPressed: () {
                  availbility();
                }
            ),
          ),
          Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Busservices")
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasData) {
                  return Container(
                    height: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, i) {
                        return ListTile(
                          title: Text(snapshot.data.docs[i]['busname']),
                          subtitle: Row(
                            children: [
                              Text(snapshot.data.docs[i]['origin']),
                              SizedBox(width: 10,),
                              Text(snapshot.data.docs[i]['destination']),

                            ],
                          ),
                          trailing: Text(snapshot.data.docs[i]['bustiming']),


                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),


        ],
      ),
    );
  }
   availbility(){
    if(NewDropdown.selecttime==FirebaseFirestore.instance.collection('Busservices').where('bustiming',isLessThan: NewDropdown.selecttime).get().then((value){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Buses are available')));
    })){}
    else if(NewDropdown.selecttime==FirebaseFirestore.instance.collection('Busservices').where('bustiming',isGreaterThan: NewDropdown.selecttime).get().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Buses are not availble')));
    })){}
   }
 }

