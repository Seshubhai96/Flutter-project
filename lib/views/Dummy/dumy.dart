import 'package:flutter/material.dart';

class Dunnyscreen extends StatefulWidget {
  @override
  _DunnyscreenState createState() => _DunnyscreenState();
}

class _DunnyscreenState extends State<Dunnyscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ElevatedButton(
          child: Text('click'),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
              children: [
                Text('hey u clicked'),
                Icon(Icons.add),
              ],
            )));
          },
        ));
  }
}
