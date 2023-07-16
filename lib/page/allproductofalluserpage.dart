import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import 'allproductofalluser_showdetailpage.dart';

class AllProductOfAllUserPage extends StatefulWidget {
  const AllProductOfAllUserPage({Key? key}) : super(key: key);

  @override
  _AllProductOfAllUserPageState createState() => _AllProductOfAllUserPageState();
}

class _AllProductOfAllUserPageState extends State<AllProductOfAllUserPage> {
  Stream _MySteam()async*{
    yield* Stream.periodic(const Duration(seconds: 1),(int){
      //اینجا کدم رو مینویسم تا به صورت خودکار رفرش بشه
    });
  }
  ProductCRUD _productCRUD=ProductCRUD();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      // appBar: AppBar(
      //   title: Text('Products',style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),),
      // backgroundColor: Theme.of(context).primaryColor,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [
      //           deepBlue,
      //           blue,
      //         ]
      //       )
      //     ),
      //   ),
      // ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          color: white,
          child: FutureBuilder(
            future: _productCRUD.getProductData(),
            builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Center(child: Text('Somethings went wrong: ${snapshot.error}'));
              }else if(!snapshot.hasData && snapshot.connectionState==ConnectionState.done){
                return Center(child: Text('Document does not exist',style: TextStyle(color: white),));
              }else if(snapshot.hasData){
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // DocumentSnapshot document = snapshot.data!.docs[index];
                            // final data =document;
                            final data=snapshot.data;
                            // print(data.docs[4]['name']);
                            return GestureDetector(
                              onDoubleTap: (){
                                Get.toNamed('/ShopCardPage' );
                              },
                              onTap: (){
                                // Navigator.of(context).pushNamed('/ShowProductPage');
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                                    AllProductOfAllUser_ShowDetailPage(
                                  id: data.docs[index].id,
                                  userId: data.docs[index]['userId'],
                                  name: data.docs[index]['name'],
                                  brand: data.docs[index]['brand'],
                                  model: data.docs[index]['model'],
                                  price: data.docs[index]['price'],
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
                              child: Card(
                                color: blue,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(data.docs[index]['name'].toString(),style: TextStyle(fontSize: 15,color: white),),
                                      const SizedBox(width: 150,),
                                      // Checkbox(value:data.docs[index]['addedToShopCard'] , onChanged: (newVal){}),
                                    ],
                                  ),
                                  subtitle: Text(data.docs[index]['price'].toString() + '\$' ,
                                    style: const TextStyle(color: Colors.lightGreenAccent),),
                                  leading: CircleAvatar(
                                    backgroundColor: blue,
                                    radius: 25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: data.docs[index]['imageProduct'].toString().isNotEmpty ?
                                      Image.network(data.docs[index]['imageProduct'].toString(),
                                        fit: BoxFit.contain,)
                                          : Image.asset('assets/img.png',fit: BoxFit.fill,),
                                    ),
                                  ),
                                  // subtitle: Text(DateFormat('yyyy_mm_dd').format(DateTime.now()).toString()),
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
      )
      // floatingActionButton: Directionality(
      //   textDirection: TextDirection.rtl,
      //   child: FloatingActionButton(
      //     tooltip: 'تیکت جدید',
      //     child:new Container(child: Icon(Icons.add,color: white,size: 30,)),
      //     onPressed: (){
      //       showDialog(
      //           context: context,
      //           builder: (BuildContext context){
      //             return AlertDialog(
      //               clipBehavior: Clip.antiAliasWithSaveLayer,
      //               buttonPadding: EdgeInsets.all(50),
      //               scrollable: true,
      //               insetPadding: EdgeInsets.all(10),
      //               backgroundColor: Colors.white,
      //               shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      //               title: Text('تیکت جدید'),
      //               actions: [
      //                 CustomTextFromField(suffixIcon: Icon(Icons.article),hintText: 'عنوان تیکت',isobsecure: false,),
      //               ],
      //             );
      //           }
      //       );
      //     },
      //     backgroundColor: lightBlue,
      //   ),
      // ),
    );
  }
}
