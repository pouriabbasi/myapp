import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/page/showproductpage.dart';
import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import 'showdialogforaddproduct.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, }) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ProductCRUD _productCRUD=ProductCRUD();

  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userUId);
    // print(getLastIdModel('products'));
    // Global.test();

  }

  @override
  Widget build(BuildContext context) {
    // final fileName =file != null ? file!.path : 'No File Selected Yet';
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: blue,
    // appBar: AppBar(title: Text('HomePage',style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),),
    //   backgroundColor: Theme.of(context).primaryColor,
    //   leading: IconButton(icon: Icon(Icons.refresh,color: Colors.white,),
    //     onPressed: (){
    //       Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
    //     },
    //   ),
    //   actions: [
    //     TextButton(
    //         onPressed: (){
    //           Navigator.of(context).pushNamed('/ShowUserPage');
    //         },
    //         child: Padding(padding: EdgeInsets.all(10),
    //     child: Icon(Icons.person,color: Colors.white,),)
    //     ),
    //     TextButton(onPressed: (){}, child: Padding(padding: EdgeInsets.all(10),
    //       child: Icon(Icons.search,color: Colors.white,),)
    //     ),
    //     TextButton(
    //         onPressed: (){
    //           FirebaseAuth.instance.signOut().then((_) => Navigator.of(context).pushReplacementNamed('/LoginPage'));
    //           },
    //         child: Padding(padding: EdgeInsets.all(10),
    //           child: Icon(Icons.login_outlined,color: Colors.white,),)
    //     ),
    //   ],
    //   flexibleSpace: Container(
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(colors: [
    //         deepBlue,
    //         blue,
    //       ])
    //     ),
    //   ),
    // ),
    body: ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
      child: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        color: white,
        child: StreamBuilder<QuerySnapshot>(
          // stream: FirebaseFirestore.instance.collection('products').where('userId',isEqualTo: userUId).snapshots(),
          stream: _productCRUD.readProduct(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(child: Text('Somethings went wrong: ${snapshot.error}'));
            }else if(!snapshot.hasData  && snapshot.connectionState==ConnectionState.done){
              return Center(child: Text('Document does not exist',style: TextStyle(color: white),));
            }if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        // DocumentSnapshot document = snapshot.data!.docs[index];
                        // final data =document;
                          final data=snapshot.requireData;
                          // print(data.docs[4]['name']);
                          return GestureDetector(
                            onTap: (){
                              // Navigator.of(context).pushNamed('/ShowProductPage');
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShowProductPage(
                                id: data.docs[index].id,
                                userId: data.docs[index]['userId'],
                                name: data.docs[index]['name'],
                                brand: data.docs[index]['brand'],
                                model: data.docs[index]['model'],
                                price: data.docs[index]['price'],
                                count: data.docs[index]['count'],
                                color: data.docs[index]['color'],
                                imageProduct: data.docs[index]['imageProduct'],
                                material: data.docs[index]['material'],
                                categoryId: data.docs[index]['categoryId'],
                                categoryName: data.docs[index]['categoryName'],
                                description: data.docs[index]['description'],
                                timeProduct: DateTime.parse(data.docs[index]['timeProduct'].toDate().toString()),
                                expiration: DateTime.parse(data.docs[index]['expiration'].toDate().toString()),
                                timeAddProduct: DateTime.parse(data.docs[index]['timeAddProduct'].toDate().toString()),
                              )
                              )
                              );
                            },
                            child: Container(
                              child: Card(
                                child: ListTile(
                                  subtitle: Text(data.docs[index]['price'].toString() + '\$' ,
                                    style: TextStyle(color: Colors.lightGreenAccent),),
                                  leading: CircleAvatar(
                                    backgroundColor: blue,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: data.docs[index]['imageProduct'].toString().isNotEmpty ?
                                        Image.network(data.docs[index]['imageProduct'].toString(),
                                          fit: BoxFit.contain,)
                                            : Image.asset('assets/img.png',fit: BoxFit.fill,),
                                      ),
                                      radius: 25,
                                    ),

                                  title: Text(data.docs[index]['name'].toString(),style: TextStyle(fontSize: 15,color: white),),
                                  // subtitle: Text(DateFormat('yyyy_mm_dd').format(DateTime.now()).toString()),
                                ),
                                color: blue,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            }else{
              return Center(child: Text('Loading...',style: TextStyle(color: white),));
            }
          },
        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlue,
        child: Icon(Icons.add,color: white,size: 30,),
        onPressed: ()async{
            await showDialogForAddProduct(context);
        },
      ),
    );
  }
}



