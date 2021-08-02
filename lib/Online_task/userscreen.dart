import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userscreen extends StatefulWidget {


  @override
  _UserscreenState createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text("Check Your Vaccine details"),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("orders").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){}
              if(snapshot.hasData)
                return Container(
                  height: double.maxFinite,
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_,i){
                      return ListTile(
                        title: Text(snapshot.data.docs[i]["personname"]),
                        subtitle: Text(snapshot.data.docs[i]["dosetype"]),
                        trailing: Column(
                          children: [
                            Text(snapshot.data.docs[i]["location"]),
                            Text(snapshot.data.docs[i]["vaccinetype"]),
                          ],
                        ),
                      );
                    },
                  ),
                );
          },
          ),
        ],
      ),
    );
  }
}
