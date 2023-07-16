import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/globalvar.dart';
import 'adminpage_tab1page.dart';
import 'adminpage_tab2page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: blue,
          appBar:new AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightBlue,
                    deepBlue,
                  ]
                )
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person),),
                Tab(icon: Icon(Icons.article),),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              children: [
                AdminPage_Tab1Page(),
                AdminPage_Tab2Page(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,size: 14,),
            onPressed: (){
              // CategoryModel categoryModel=CategoryModel();
              // categoryModel.categoryName='food';
              // categoryModel.categoryImage='https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.today.com%2Fhealth%2Fdiet-fitness%2Fsuper-foods&psig=AOvVaw2m1tIHePHVBugM5ewx5C0C&ust=1651011600791000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCPDX0tKfsPcCFQAAAAAdAAAAABAD';
              // categoryModel.products=[
              //   ProductModel(userId: userUId,color: 'blue',isAccess: true,price: 200),
              //   ProductModel(userId: userUId,color: 'red',isAccess: true,price: 300),
              //   ProductModel(userId: userUId,color: 'green',isAccess: true,price: 400),
              // ];
              // FirebaseFirestore.instance.collection('category').add(categoryModel.toJson()).then((value) =>
              // Get.snackbar('Category', 'Success Added!'));
            },
          ),
        ),
      );
  }
}
