import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../CRUD/crudcategory.dart';
import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import '../models/productmodel.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  String? value;
  FirebaseStorage storage=FirebaseStorage.instance;
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  ProductCRUD _productCRUD =ProductCRUD();

  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
    CurvedAnimation curved = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animation=Tween(begin: 50.0,end:300.0).animate(curved);
    animation.addStatusListener((AnimationStatus status) =>setState(() {
      if(status == AnimationStatus.completed){
        animationController.reverse();
      }else if(status ==AnimationStatus.dismissed){
        animationController.forward();
      }
    }));
    animationController.forward();
    // value=CategoryCRUD.list[0];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(title: Text('Setting',style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).primaryColor,
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
        child: Column(
          children: [
            FirestoreSearchBar(tag: 'example',),
            FirestoreSearchResults.builder(
              tag: 'example',
              firestoreCollectionName: 'products',
              searchBy: 'name',
              initialBody: const Center(child: Text('Initial body'),),
              dataListFromSnapshot: _productCRUD.dataListFromSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<ProductModel>? dataList = snapshot.data;
                  if (dataList!.isEmpty) {
                    return const Center(
                      child: Text('No Results Returned'),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final ProductModel data = dataList[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${data.name}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 8.0, right: 8.0),
                                child: Text('${data.name}',
                                    style: Theme.of(context).textTheme.bodyText1),
                              )
                            ],
                          );
                        });
                  }
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Results Returned'),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Row(
              children: [
                Text('x'),
                Slider(value: _x, onChanged: (double value)=>setState(()=> _x=value )),
              ],
            ),
            Row(
              children: [
                Text('y'),
                Slider(value: _y, onChanged: (double value)=>setState(()=> _y=value )),
              ],
            ),
            Row(
              children: [
                Text('z'),
                Slider(value: _z, onChanged: (double value)=>setState(()=> _z=value )),
              ],
            ),
            Transform(
                transform: Matrix4.skewY(_y),
              child: Transform(
                transform: Matrix4.skewX(_x),
                child: Transform(
                transform: Matrix4.rotationZ(_z),
                child: AnimatedBuilder(
                  animation: animation,
                builder: (context , widget){
                    return Opacity(
                      opacity: 1,
                      child: Container(
                        padding: EdgeInsets.all(32),
                        height: animation.value,
                        width: animation.value,
                        child: Center(
                          child: Transform.rotate(angle: Tween(begin: 0.0,end: 0.5).evaluate(animation),
                            child: FlutterLogo(size: 200,),
                          )
                        ),
                      ),
                    );
                },
                )
                ),
              ),
            ),
          ],
        ),
      )
      // Column(
      //   children: [
      //     ElevatedButton(
      //         onPressed: ()async{
      //           final result=await FilePicker.platform.pickFiles(
      //             allowMultiple: false,
      //             type: FileType.custom,
      //             allowedExtensions: ['jpg','png']
      //           );
      //           if(result==null){
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(content: Text('No file selected')));
      //           }
      //           final path = result!.files.single.path;
      //           final fileName = result.files.single.name;
      //
      //           File file=File(path!);
      //
      //           storage.ref('imagesProduct/$fileName').putFile(file).then((_) => print('Well done!'));
      //
      //         },
      //   child: Text('TestPick')
      //     ),
      //   ],
      // ),
    );
  }

}