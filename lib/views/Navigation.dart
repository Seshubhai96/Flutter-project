import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/views/Fav.dart';
import 'package:flutter_application_3/views/project_views/Home.dart';
import 'package:flutter_application_3/views/project_views/cart.dart';
import 'package:flutter_application_3/views/search.dart';

class Bottomnavscreen extends StatefulWidget {
  @override
  _BottomnavscreenState createState() => _BottomnavscreenState();
}

class _BottomnavscreenState extends State<Bottomnavscreen> {
  void selectedpage(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List<Map<String, Object>> nav;
  int selectedindex = 0;
  @override
  void initState() {
    nav = [
      {'page': Homescreen(), 'title': "Happy Shopping  !!!"},
      {
        'page': Searchscreen(),
        'title': "",
      },
      {'page': Carstscreen(), 'title': ""},
      {'page': Favoritescreen(), 'title': " MY Favorite "},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nav[selectedindex]['title']),
      ),
      body: nav[selectedindex]['page'],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: selectedpage,
          currentIndex: selectedindex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.black,
          // selectedIconTheme:
          //     IconThemeData(opacity: 8, color: Colors.purpleAccent, size: 30),
          // unselectedIconTheme:
          //     IconThemeData(opacity: 8, color: Colors.red, size: 30),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: null,
              icon: Icon(null),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: ' Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          setState(() {
            selectedindex = 1;
          });
        },
      ),
      drawer: Drawer(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Userdata')
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          // ignore: missing_return
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (_, i) {
                return DrawerHeader(
                    child: ListTile(
                  //leading: ,
                  title: Text(
                    snapshot.data.docs[i]['username'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black),
                  ),
                  subtitle: Text(snapshot.data.docs[i]['useremail'].toString()),
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
