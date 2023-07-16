import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/globalvar.dart';
import '../models/productmodel.dart';

class ProductCRUD{

  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;

  bool isLoggedIn(){
    if(userUId.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<void> createProduct(ProductModel productModel)async{
    if(isLoggedIn()==true){
      ProductModel pm=ProductModel(
        userId: '',
        //user:await Global.theUserWhenLoggedIn()
      );
      pm.userId=userUId;
      pm.count= productModel.count;
      pm.name=productModel.name;
      pm.color=productModel.color;
      pm.categoryId=productModel.categoryId;
      pm.categoryName=productModel.categoryName;
      pm.brand=productModel.brand;
      pm.expiration=productModel.expiration;
      pm.material=productModel.material;
      pm.model=productModel.model;
      pm.description=productModel.description;
      pm.price=productModel.price;
      pm.isAccess=productModel.isAccess;
      pm.isBought=productModel.isBought;
      pm.imageProduct=productModel.imageProduct;
      pm.timeAddProduct=productModel.timeAddProduct;
      pm.timeProduct=productModel.timeProduct;

      fireStore.collection('products').doc().set(pm.tojson()).catchError((error){
        print(error);
      });

      // fireStore.collection('users').doc(userUId).collection('products').doc().set(pm.tojson()).catchError((error){
      //   print(error);
      //
      // });


    }else{
      print('you must logging');
    }

  }

  Future<QuerySnapshot<Map<String, dynamic>>?>getProductData()async{
    if(Global.isLoggedIn()==true){
      return await fireStore.collection('products')
          .where('isAccess',isEqualTo: true,).get().
      catchError((error){
        print(error.message);
      });
    }else{
      return null;
    }
  }

  // Stream <List<ProductModel>> readProduct(){
  //   return fireStore.collection('users').doc(userUId).collection('products').snapshots().map((snapshot) =>
  //   snapshot.docs.map((doc) => ProductModel.fromjson(doc.data())).toList());
  // }
  Stream <QuerySnapshot<Object?>> readProduct(){
    return fireStore.collection('products').where('userId',isEqualTo: userUId).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readProductForAdmin()async{
    return await fireStore.collection('products').where('isAccess',isEqualTo: false).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getIsAccess(String id)async{
    return await fireStore.collection('products').doc(id).get();
  }

  Future<void> updateProduct(String selectDoc,Map<String,dynamic> newValue)async{
    await fireStore.collection('products').doc(selectDoc).update(newValue).catchError((error){
      print('Method Update Error : ${error}');
    });
    //     .then((value)async{
    //   DocumentSnapshot _documentSnapshot =await fireStore.collection('products').doc(selectDoc).get();
    //   if(_documentSnapshot.get('count')==0){
    //     updateProduct(selectDoc, {'isBought':true});
    //   }
    // }
    // );
    // await fireStore.collection('users').doc(userUId).collection('products').doc(selectDoc).update(newValue.tojson()).catchError((error){
    //   print(error);
    // });
  }

  Future<void> deleteProduct(String selectDoc)async{
    await fireStore.collection('products').doc(selectDoc).delete().catchError((error){
      print(error);
    });
    // await fireStore.collection('users').doc(userUId).collection('products').doc(selectDoc).delete().catchError((error){
    //   print(error);
    // });
  }

  List<ProductModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> jsondata = snapshot.data() as Map<String, dynamic>;

      return ProductModel(
          name: jsondata['name'] ,
          model: jsondata['model'],
          brand: jsondata['brand'],
          price: jsondata['price'],
          material: jsondata['material'],
          count:jsondata['count'] ?? 0,
          color: jsondata['color'],
          categoryId: jsondata['category'],
          categoryName: jsondata['categoryName'],
          description: jsondata['description'],
          timeProduct: jsondata['timeProduct'],
          expiration: jsondata['expiration'],
          timeAddProduct: jsondata['timeAddProduct'] ,
          imageProduct: jsondata['imageProduct'],
          userId: jsondata['userId'],
          isAccess: jsondata['isAccess'],
          isBought:jsondata['isBought'],
          pictureFile: jsondata['pictureFile'],
      );
    }).toList();
  }
}
