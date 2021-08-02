import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchcontoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: searchcontoller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)))),
          ),
        ),
      ),
    );
  }
}
