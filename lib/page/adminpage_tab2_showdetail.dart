import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import '../widgets/buttonwidget.dart';

class AdminPage_Tab2_ShowDetail extends StatefulWidget {

  AdminPage_Tab2_ShowDetail({
      required this.id,
      this.name,
      this.model,
      this.brand,
      this.description,
      this.price,
      this.material,
      this.color,
      this.categoryName,
      this.timeProduct,
      this.expiration,
      this.timeAddProduct,
      this.imageProduct,
      this.pictureFile,
      required this.isAccess,
      required this.userId
  });

  final String id;
  final String? name;
  final String? model;
  final String? brand;
  final String? description;
  final int? price;
  final String? material;
  final String? color;
  final String? categoryName;
  bool isAccess;
  final DateTime? timeProduct;
  final DateTime? expiration;
  final DateTime? timeAddProduct;
  final String? imageProduct;
  final File? pictureFile;
  // UserModel? user=UserModel();
  // List<UserModel> users=[]; for n:m relation
  final String userId;

  @override
  State<AdminPage_Tab2_ShowDetail> createState() => _AdminPage_Tab2_ShowDetailState();
}

class _AdminPage_Tab2_ShowDetailState extends State<AdminPage_Tab2_ShowDetail> {
  bool showCheckBox = false;
  ProductCRUD _productCRUD=ProductCRUD();
  late bool access;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCRUD.getIsAccess(widget.id).then((value){
      widget.isAccess!=value['isAccess'] as bool;
      access=value['isAccess'] as bool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue,
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10,top: 10),
              child: Checkbox(
                  value: widget.isAccess,
                  onChanged: (bool? newAccess){
                    setState(() {
                      if(access!=newAccess){
                        showCheckBox=true;
                      }else{
                          showCheckBox=false;
                      }
                      widget.isAccess=newAccess!;
                    });
              })
            ),
          ],
          title: Text(
            widget.name.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.5,
                fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  deepBlue,
                  blue,
                ])),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(widget.imageProduct.toString(),fit: BoxFit.contain,)
                    ),
                  ),
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
                    Text('Material:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.material!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Color:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.color!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Category:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.categoryName!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Description:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.description!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Access to show:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.isAccess.toString(),style: TextStyle(fontSize: 14),),
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
                    Text(widget.id,style: TextStyle(fontSize: 14),),
                  ],
                ),
                showCheckBox==true ?
                Container(
                  width: 100,
                  height: 40,
                  child: CustomButton(
                    text: 'Save Change',
                    onClicked: (){
                      _productCRUD.updateProduct(widget.id, {
                        'isAccess':widget.isAccess,
                      }).then((value){
                        showCheckBox=false;
                        Get.offNamed('/AdminPage');
                      });
                    },
                  ),
                ) :
                    Text('')
              ],
            ),
          ),
        )
    );
  }
}
