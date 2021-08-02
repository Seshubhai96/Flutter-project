import 'package:cloud_firestore/cloud_firestore.dart';

class MyQuries {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static Query carsoulQuery = firebaseFirestore.collection('Carousles');

  static getcatprods(String catname) {
    return firebaseFirestore
        .collection('Products')
        .where("cat", isEqualTo: catname);
  }

  static getsubprods(String catslug) {
    return firebaseFirestore
        .collection('Products')
        .where("subcat", isEqualTo: catslug);
  }

  static getsize(String size) {
    return firebaseFirestore
        .collection('Category')
        .where("Size", isEqualTo: size);
  }
}
