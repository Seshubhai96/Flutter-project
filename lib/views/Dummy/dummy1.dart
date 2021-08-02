import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/dummy/dummymodel.dart';
import 'package:http/http.dart' as http;

class Backgroundimagewidget extends StatefulWidget {
  @override
  _BackgroundimagewidgetState createState() => _BackgroundimagewidgetState();
}

class _BackgroundimagewidgetState extends State<Backgroundimagewidget> {


   List<User> list =[];
   @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   // final width = MediaQuery.of(context).size.width;
   // final height = MediaQuery.of(context).size.height;
   // final Pad = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body:ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context,index){
          return ListTile(
            title: Text(list[index].title.toString()),
            subtitle: Text(list[index].userId.toString()),

          );
        },
      )
    );
  }

  Future<List<User>> getuser()async{
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final respone = await   http.get(url);
    final extractedresponse = json.decode(respone.body);
    //method one
    return (extractedresponse as List).map((e) => User.fromJSON(e)).toList();
  }

 void getData()async{
     final client =Uri.parse('https://jsonplaceholder.typicode.com/posts');
     final response = await http.get(client);
     final extractedresponse =json.decode(response.body);
     print(extractedresponse);
     final List<User> loadeddata=[];
      return extractedresponse.forEach((s){
      loadeddata.add(User(
        id: s['id'],
        userId: s['userId'],
        title: s['title'],
        body: s['body'],

      ));
      setState(() {
        list=loadeddata;
      });
   });

 }

}

//method 2


// ListView(
//         shrinkWrap: true,
//         physics: AlwaysScrollableScrollPhysics(),
//         children: [
//           Column(
//             children: [
//               Container(
//                 height:height*0.4,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/Category%2Ffreestocks-_3Q3tsJ01nc-unsplash.jpg?alt=media&token=6ea53652-7e88-41cb-9e27-996a1f63167e'),
//                     colorFilter: ColorFilter.mode(
//                         Colors.orange.withOpacity(0.65), BlendMode.modulate),
//                     fit: BoxFit.fill,
//                   ),
//                 ),),
//               Container(
//                 height:500 ,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Colors.yellow,Colors.purple]),
//                   //borderRadius: BorderRadius.all(Radius.circular(100)),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 30,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             color: Colors.blue[900],
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           ),
//                           child: Text('LOGIN',style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),textAlign: TextAlign.center,),
//                         ),
//                         InkWell(
//                           onTap: (){},
//                           child: Container(
//                             height: 30,
//                             width: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(20)),
//                             ),
//                             child: Text('Signup',style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.blue[900]),textAlign: TextAlign.center,),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10,),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Form(
//                         child: Column(
//                           children: [
//                             // email
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                                   )
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             // password
//                             TextFormField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                                   )
//                               ),
//                             ),
//                             SizedBox(height: 20,),
//                             Container(
//                               alignment: Alignment.bottomRight,
//                               child: TextButton(
//                                   onPressed: (){}, child: Text('Forgot password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
//                             ),
//                             SizedBox(height: 25,),
//                             Container(
//                               height: 40,
//                               width: 180,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[900],
//                                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                               ),
//
//                               child: Text('LOGIN',style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white,),textAlign: TextAlign.center,),
//                             ),
//                             SizedBox(height: 30,),
//                             Text("OR",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                             SizedBox(height: 20,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: (){},
//                                   child: SizedBox(
//                                     height: 50,
//                                       child: Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/download.png?alt=media&token=cd86ede9-1cd1-4de2-af7d-653df555d585')),
//                                 ),
//                                 SizedBox(width: 15,),
//                                 InkWell(
//                                   onTap: (){},
//                                   child: SizedBox(
//                                     height: 40,
//                                       child: Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce-af81b.appspot.com/o/download%20(1).png?alt=media&token=cbaa5e6b-7e2a-40e0-9e1b-39c8f6cc4032')),
//                                 ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),