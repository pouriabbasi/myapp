

import 'package:myapp/models/productmodel.dart';

class CategoryModel {
  String? categoryName;
  String? categoryImage;
  List<ProductModel>?products=[];

  CategoryModel({this.categoryName, this.categoryImage, this.products});

  factory CategoryModel.fromJson(Map<String,dynamic>jsonData){
    return CategoryModel(
      categoryName: jsonData['categoryName'],
      categoryImage: jsonData['categoryImage'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'categoryName':categoryName,
      'categoryImage':categoryImage,
    };
  }
 }