import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/productmodel.dart';

class UserModel {
  String? uId;
  String? name;
  String? family;
  String? phoneNumber;
  int? age;
  String? gender;
  String? address;
  String? business;
  String? email;
  String? password;
  String? imageUrl;
  DateTime? userAdded;
  String roll;
  List<ProductModel> product = [];
  UserModel({this.uId ,this.name, this.family, this.age, this.gender, this.address,required this.roll,
    this.business,this.email,this.imageUrl,this.password,this.phoneNumber,this.userAdded,});

  factory UserModel.fromjson(Map<String,dynamic>jsondata){
    return UserModel(
      uId: jsondata['uId'],
      name: jsondata['name'],
      roll: jsondata['roll'],
      family: jsondata['family'],
      age: jsondata['age'],
      address: jsondata['address'],
      gender: jsondata['gender'],
      business: jsondata['business'],
      email: jsondata['email'],
      password: jsondata['password'],
      imageUrl: jsondata['imageUrl'],
      phoneNumber: jsondata['phoneNumber'],
      userAdded: jsondata['userAdded'],
    );
  }

  Map<String,dynamic> tojson(){
    return {
      'uId':uId,
      'name':name,
      'roll':roll,
      'family':family,
      'age':age,
      'gender':gender,
      'address':address,
      'business':business,
      'email':email,
      'imageUrl':imageUrl,
      'password':password,
      'phoneNumber':phoneNumber,
      'userAdded':userAdded,
    };
  }

}
