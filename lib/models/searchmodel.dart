import 'package:cloud_firestore/cloud_firestore.dart';

class SearchModel {
  final String? name;
  final String? imageProduct;
  final String? price;
  final String? userId;
  final String? categoryId;

  SearchModel({this.name, this.imageProduct,this.categoryId,this.userId,this.price});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<SearchModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return SearchModel(
          name: dataMap['name'],
          imageProduct: dataMap['imageProduct'],
      );
    }).toList();
  }
}