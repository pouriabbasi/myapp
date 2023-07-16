import 'package:flutter/material.dart';

import '../CRUD/crudusers.dart';
import '../models/globalvar.dart';
import 'adminpage_tab1_showdetail.dart';
import 'allproductofalluser_showdetailpage.dart';

class AdminPage_Tab1Page extends StatefulWidget {
  const AdminPage_Tab1Page({Key? key}) : super(key: key);

  @override
  State<AdminPage_Tab1Page> createState() => _AdminPage_Tab1PageState();
}

class _AdminPage_Tab1PageState extends State<AdminPage_Tab1Page> {
  UsersCRUD _usersCRUD = UsersCRUD();
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
            child: Center(child: Text('User',style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.bold),),),
            decoration: BoxDecoration(
              color: deepBlue,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70),)
            ),
          ),
          FutureBuilder(
            future: _usersCRUD.readAll(),
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
                          final data=snapshot.data;
                          // print(data.docs[4]['name']);
                          return GestureDetector(
                            onTap: (){
                              // Navigator.of(context).pushNamed('/ShowProductPage');
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AdminPage_Tab1_ShowDetail(
                                uId: data.docs[index].id,
                                name: data.docs[index]['name'],
                                family: data.docs[index]['family'],
                                phoneNumber: data.docs[index]['phoneNumber'],
                                age: data.docs[index]['age'],
                                address: data.docs[index]['address'],
                                imageUrl: data.docs[index]['imageUrl'],
                                business: data.docs[index]['business'],
                                email: data.docs[index]['email'],
                                roll: data.docs[index]['roll'],
                                gender: data.docs[index]['gender'],
                              )
                              )
                              );
                            },
                            child: Container(
                              child: Card(
                                child: ListTile(
                                  subtitle: Text(data.docs[index]['family'].toString()),
                                  leading: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: data.docs[index]['imageUrl'].toString().isNotEmpty ?
                                      Image.network(data.docs[index]['imageUrl'].toString(),
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