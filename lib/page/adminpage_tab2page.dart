import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import 'adminpage_tab2_showdetail.dart';

class AdminPage_Tab2Page extends StatefulWidget {
  const AdminPage_Tab2Page({Key? key}) : super(key: key);

  @override
  State<AdminPage_Tab2Page> createState() => _AdminPage_Tab2PageState();
}

class _AdminPage_Tab2PageState extends State<AdminPage_Tab2Page> {
  ProductCRUD _productCRUD=ProductCRUD();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: blue,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height:size.height / 7 ,
            width: size.width,
            child: Center(child: Text('Product',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.bold),),),
            decoration: BoxDecoration(
                color: deepBlue,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70),)
            ),
          ),
          FutureBuilder(
            future: _productCRUD.readProductForAdmin(),
            builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Center(child: Text('Somethings went wrong: ${snapshot.error}'));
              }else if(!snapshot.hasData && snapshot.connectionState==ConnectionState.done){
                return Center(child: Text('Document does not exist',style: TextStyle(color: white),));
              }else if(snapshot.hasData){
                return Column(
                  children: [
                    SizedBox(height: 5,),
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
                              // Navigator.of(context).pushNamed('/ShowProductPage',);
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AdminPage_Tab2_ShowDetail(
                                id: data.docs[index].id,
                                userId: data.docs[index]['userId'],
                                name: data.docs[index]['name'],
                                brand: data.docs[index]['brand'],
                                model: data.docs[index]['model'],
                                price: data.docs[index]['price'],
                                color: data.docs[index]['color'],
                                imageProduct: data.docs[index]['imageProduct'],
                                material: data.docs[index]['material'],
                                categoryName: data.docs[index]['categoryName'],
                                description: data.docs[index]['description'],
                                timeProduct: DateTime.parse(data.docs[index]['timeProduct'].toDate().toString()),
                                expiration: DateTime.parse(data.docs[index]['expiration'].toDate().toString()),
                                timeAddProduct: DateTime.parse(data.docs[index]['timeAddProduct'].toDate().toString()),
                                isAccess: data.docs[index]['isAccess'],
                              )
                              )
                              );
                            },
                            child:  Container(
                              child: Card(
                                child: ListTile(
                                  subtitle: Text(data.docs[index]['price'].toString()),
                                  leading: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: data.docs[index]['imageProduct'].toString().isNotEmpty ?
                                      Image.network(data.docs[index]['imageProduct'].toString(),
                                        fit: BoxFit.contain,)
                                          : Image.asset('assets/img.png',fit: BoxFit.fill,),
                                    ),
                                    radius: 25,
                                  ),

                                  title: Text(data.docs[index]['name'].toString(),style: TextStyle(fontSize: 15),),
                                  // subtitle: Text(DateFormat('yyyy_mm_dd').format(DateTime.now()).toString()),
                                ),
                                color: white,
                              ),
                            ),
                          );
                        }),
                  ],
                );
              }else{
                return Center(child: Text('Loading...',style: TextStyle(color: white),));
              }
            },
          ),
        ],
      ),
    );
  }
}
