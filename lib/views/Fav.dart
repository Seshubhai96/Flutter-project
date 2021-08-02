import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';

// ignore: must_be_immutable
class Favoritescreen extends StatefulWidget {
  @override
  _FavoritescreenState createState() => _FavoritescreenState();
}

class _FavoritescreenState extends State<Favoritescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: FlutterCart().cartItem.length,
      itemBuilder: (_, i) {
        return ListTile(
          leading: Image.network(FlutterCart().cartItem[i].uniqueCheck),
          title: Text(FlutterCart().cartItem[i].productDetails),
          subtitle: Text(FlutterCart().cartItem[i].unitPrice),
          trailing: Text(FlutterCart().cartItem[i].quantity.toString()),
        );
      },
    ));
  }
}
