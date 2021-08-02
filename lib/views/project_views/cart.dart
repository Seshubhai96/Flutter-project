import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/Carst%20services.dart';
import 'package:flutter_application_3/views/placeorder.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Carstscreen extends StatefulWidget {
  @override
  _CarstscreenState createState() => _CarstscreenState();
}

class _CarstscreenState extends State<Carstscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          elevation: 0.0,
          title: Text("MyCart 🛒 (${FlutterCart().cartItem.length} Items)"),
          actions: [
            IconButton(
                tooltip: "Empty cart",
                icon: Icon(Icons.clear_all),
                onPressed: () {
                  Mycart.clearCart();
                  setState(() {});
                })
          ],
        ),
        body: ListView.separated(
          separatorBuilder: (_, i) {
            return Divider(
              height: 4,
            );
          },
          itemCount: FlutterCart().cartItem.length,
          itemBuilder: (_, index) {
            return ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() => Mycart.removefromcart(index));
                },
              ),
              leading: Image.network(
                FlutterCart().cartItem[index].uniqueCheck,
                fit: BoxFit.fill,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    FlutterCart().cartItem[index].productName,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text("₹ " +
                      FlutterCart().cartItem[index].unitPrice.toString()),
                ],
              ),
              subtitle: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() => Mycart.decrementitem(index));
                      }),
                  Text(FlutterCart().cartItem[index].quantity.toString()),
                  IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        setState(() => Mycart.incrementitem(index));
                      }),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          height: height * 0.09,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TotalAmount: "
                " ₹"
                " ${FlutterCart().getTotalAmount()}",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    if (FlutterCart().cartItem.length == 0) {
                      return Fluttertoast.showToast(msg: "Add item to proceed");
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Placeorder()));
                    }
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ));
  }
}
