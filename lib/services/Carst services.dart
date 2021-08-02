import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mycart {
  static FlutterCart cart = FlutterCart();

  static removefromcart(index) {
    cart.deleteItemFromCart(index);
    onCartChanged();
  }

  static incrementitem(index) {
    if (cart.cartItem[index].quantity > 4) {
      Fluttertoast.showToast(msg: "Only 5 are allowed");
      return;
    }
    cart.incrementItemToCart(index);
    onCartChanged();
  }

  static decrementitem(index) {
    cart.decrementItemFromCart(index);
    onCartChanged();
  }

  static addtocart(String id, String name, String image, int qty, int price) {
    cart.addToCart(
        productId: id,
        unitPrice: price,
        productName: name,
        quantity: qty,
        uniqueCheck: image);
    print(name + "added sucessfully product");
    onCartChanged();
  }

  static clearCart() {
    cart.deleteAllCart();
    onCartChanged();
  }

  static syncCart(Function updateState) {
    // read
    String uid = FirebaseAuth.instance.currentUser.uid;

    FirebaseFirestore.instance
        .collection("Userdata")
        .doc(uid)
        .get()
        .then((user) async {
      // Fetch cart from db
      if (!user.exists) return;
      var cartItems = user.data()['cart']; // All cart items
      if (cartItems != null && cartItems.isNotEmpty) {
        // When cart is not empty.
        cartItems.forEach((item) {
          addtocart(item['id'], item['name'], item['image'], item['price'],
              item['qty']);
        });
        updateState();
      }
    });
  }

  static onCartChanged() async {
    // write
    String uid = FirebaseAuth.instance.currentUser.uid;
    var allItems = cart.cartItem
        .map((item) => {
              "id": item.productId,
              "name": item.productName,
              "image": item.uniqueCheck,
              "qty": item.quantity,
              "price": item.unitPrice
            })
        .toList();

    FirebaseFirestore.instance
        .collection("Userdata")
        .doc(uid)
        .update({"cart": allItems});
  }
}
