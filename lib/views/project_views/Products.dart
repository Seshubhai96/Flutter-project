import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/Carst%20services.dart';
import 'package:flutter_application_3/services/Quries.dart';
import 'package:flutter_application_3/views/Details.dart';
import 'package:flutter_application_3/views/project_views/cart.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Productsscreen extends StatefulWidget {
  String catname;
  List catslug;

  Productsscreen({
    this.catname,
    this.catslug,
  });
  @override
  _ProductsscreenState createState() => _ProductsscreenState();
}

class _ProductsscreenState extends State<Productsscreen> {
  ScrollController scrollController = ScrollController();
  String aciveid = "All";
  bool fav = false;
  @override
  void initState() {
    super.initState();
    Mycart.syncCart(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    List<Widget> prolist =
        widget.catslug.map((p) => subprolist(p, i++, () {})).toList();
    prolist.insert(0, subprolist("All", 0, () {}));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.catname),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Carstscreen()));
                },
                iconSize: 30,
              ),
              Positioned(
                right: -15,
                left: 0,
                top: 1,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      "${FlutterCart().cartItem.length}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        thickness: 10,
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: prolist,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: aciveid == "All"
                  ? MyQuries.getcatprods(widget.catname).snapshots()
                  : MyQuries.getsubprods(aciveid).snapshots(),
              // ignore: missing_return
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 4, crossAxisCount: 2),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, i) {
                      return Card(
                        elevation: 5,
                        child: Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Detailview(
                                                productname: snapshot
                                                    .data.docs[i]['name'],
                                                productimage: snapshot
                                                    .data.docs[i]['image'],
                                                size: snapshot.data.docs[i]
                                                    ['size'],
                                              )));
                                },
                                child: Container(
                                    height: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data.docs[i]['image'],
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data.docs[i]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "price" +
                                        "₹" +
                                        snapshot.data.docs[i]['price']
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    "qty:" +
                                        snapshot.data.docs[i]['qty'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.purple),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Mycart.cart.getSpecificItemFromCart(
                                              snapshot.data.docs[i]['id']) ==
                                          null
                                      ? IconButton(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg: snapshot.data.docs[i]
                                                    ['name']);
                                            String id =
                                                snapshot.data.docs[i]['id'];
                                            String name =
                                                snapshot.data.docs[i]['name'];
                                            String image =
                                                snapshot.data.docs[i]['image'];
                                            int price =
                                                snapshot.data.docs[i]['price'];
                                            int qty =
                                                snapshot.data.docs[i]['qty'];
                                            setState(() {
                                              Mycart.addtocart(
                                                  id, name, image, qty, price);
                                            });
                                          },
                                          icon: Icon(Icons.add_shopping_cart))
                                      : IconButton(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg: "Already In Cart");
                                          },
                                          icon: Icon(
                                            Icons.check_box,
                                            color: Colors.green,
                                          )),
                                  //  IconButton(
                                  //     icon: Icon(
                                  //       fav
                                  //           ? Icons.favorite
                                  //           : Icons.favorite_border,
                                  //       color: Colors.pink,
                                  //     ),
                                  //     onPressed: () {
                                  //       String id = snapshot.data.docs[i]['id'];
                                  //       String name =
                                  //           snapshot.data.docs[i]['name'];
                                  //       int price =
                                  //           snapshot.data.docs[i]['price'];
                                  //       String image =
                                  //           snapshot.data.docs[i]['image'];
                                  //       int qty = snapshot.data.docs[i]['qty'];

                                  //       Mycart.addfavlist(
                                  //         id,
                                  //         name,
                                  //         image,
                                  //         price,
                                  //         qty,
                                  //       );
                                  //       setState(() {
                                  //         //  fav[i] = !fav.elementAt[i];
                                  //       });
                                  //     })
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget subprolist(p, i, callback) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.green,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(15)))),
        child: Text(p),
        onPressed: () {
          setState(() {
            aciveid = p;
          });
        },
      ),
    );
  }
}
