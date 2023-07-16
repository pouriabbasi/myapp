import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import './globalvar.dart';

class ProductModel{
  String? name;
  String? model;
  String? brand;
  int? price;
  int? count;
  String? material;
  String? color;
  String? categoryId;
  String? categoryName;
  DateTime? timeProduct;
  DateTime? expiration;
  DateTime? timeAddProduct;
  File? pictureFile;
  String? imageProduct;
  bool isAccess;
  bool isBought;
  String? description;
  // UserModel? user=UserModel();
  // List<UserModel> users=[]; for n:m relation
  String userId;

  ProductModel({
      this.name,
      this.model,
      this.brand,
      this.price,
      this.count,
      this.material,
      this.color,
      this.timeProduct,
      this.expiration,
      this.timeAddProduct,
      this.imageProduct,
      this.pictureFile,
      this.description,
      this.isAccess = false,
      this.isBought = false,
      // required this.user,
      this.categoryId,
      this.categoryName,
      required this.userId,
  });

  factory ProductModel.fromjson(Map<String,dynamic>jsondata){
    return ProductModel(
      name: jsondata['name'] ?? null,
      model: jsondata['model'] ?? null,
      brand: jsondata['brand'] ?? null,
      price: jsondata['price'] ?? null,
      material: jsondata['material'] ?? null,
      color: jsondata['color'] ?? null,
      categoryId: jsondata['category'] ?? null,
      categoryName: jsondata['categoryName'] ?? null,
      description: jsondata['description'] ?? null,
      timeProduct: jsondata['timeProduct'] ?? null,
      expiration: jsondata['expiration'] ?? null,
      timeAddProduct: jsondata['timeAddProduct'] ,
      imageProduct: jsondata['imageProduct'] ?? null,
      userId: jsondata['userId'],
      isAccess: jsondata['isAccess'],
      isBought: jsondata['isBought'],
      pictureFile: jsondata['pictureFile'],
      // user: jsondata['user']
    );
  }

  Map<String,dynamic> tojson(){
    return {
      'name':name,
      'model':model,
      'brand':brand,
      'price':price,
      'isAccess': isAccess,
      'isBought': isBought,
      'material':material,
      'color':color,
      'categoryId':categoryId,
      'categoryName':categoryName,
      'description':description,
      'timeProduct':timeProduct,
      'expiration':expiration,
      'imageProduct':imageProduct,
      'timeAddProduct':timeAddProduct,
      'userId':userId,
      'pictureFile' : pictureFile,
    };
  }
}