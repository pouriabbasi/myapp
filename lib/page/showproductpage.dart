import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/page/showdialogforupdateproduct.dart';

import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import '../models/productmodel.dart';
import '../widgets/loadingalertdialog.dart';


class ShowProductPage extends StatefulWidget {
  ShowProductPage(
      {
        this.id,
        this.name,
        this.model,
        this.brand,
        this.price,
        this.count,
        this.material,
        this.color,
        this.categoryId,
        this.categoryName,
        this.timeProduct,
        this.expiration,
        this.timeAddProduct,
        this.pictureFile,
        this.description,
        this.imageProduct,
        required this.userId
      });
  final String? id;
  final String? name;
  final String? model;
  final String? brand;
  final String? description;
  final int? price;
  final int? count;
  final String? material;
  final String? color;
  final String? categoryId;
  final String? categoryName;
  final DateTime? timeProduct;
  final DateTime? expiration;
  final DateTime? timeAddProduct;
  final String? imageProduct;
  final File? pictureFile;
  // UserModel? user=UserModel();
  // List<UserModel> users=[]; for n:m relation
  final String userId;

  @override
  State<ShowProductPage> createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  ProductCRUD _productCRUD=ProductCRUD();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue,
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text("Do You Want To Delete This Product?"),
                      actions: [
                        ElevatedButton(
                            onPressed: (){
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            }, child: Text('No')
                        ),
                        ElevatedButton(
                            onPressed: (){
                              showDialog(context: context, builder: (context)=>
                              LoadingAlertDialog(message: "Please Wait...")
                              );
                              _productCRUD.deleteProduct(widget.id!).then((_) {
                                Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
                              }
                              );
                            }, child: Text('Yes')
                        ),
                      ],
                    );
                  });
                },
                child: Padding(padding: EdgeInsets.all(10),
                  child: Icon(Icons.delete,color: Colors.white,),)
            ),
            TextButton(
                onPressed: (){
                  ProductModel pm=ProductModel(
                    userId: userUId,
                    description: widget.description,
                    name: widget.name,
                    brand: widget.brand,
                    color: widget.color,
                    count: widget.count,
                    categoryId: widget.categoryId,
                    expiration: widget.expiration,
                    imageProduct: widget.imageProduct,
                    material: widget.material,
                    model: widget.material,
                    price: widget.price,
                    timeProduct: widget.timeProduct,
                    timeAddProduct: widget.timeAddProduct,
                  );
                  showDialogForUpdateProduct(context,pm,widget.id!).then((_) {
                    showDialog(context: context, builder: (context){
                      return LoadingAlertDialog(message: 'Please Wait...',);
                    });
                    Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
                  }
                  );
                },
                child: Padding(padding: EdgeInsets.all(10),
                  child: Icon(Icons.update,color: Colors.white,),)
            ),
          ],
          title: Text(widget.name.toString(),
            style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      deepBlue,
                      blue,
                    ]
                )
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Image.network(widget.imageProduct.toString(),fit: BoxFit.fill,),
                ),
                Wrap(
                  children: [
                    Text('Name:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.name!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Model:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.model!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Brand:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.brand!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Price:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.price.toString().padLeft(3),style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Name:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.count!.toString(),style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Material:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.material!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Color:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.color!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('CategoryId:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.categoryId!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('CategoryName:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.categoryName!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Description:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.description!,style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  children: [
                    Text('userId:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.userId,style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  children: [
                    Text('id:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.id!,style: TextStyle(fontSize: 14),),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
