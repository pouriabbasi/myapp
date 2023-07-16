import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';

import '../models/globalvar.dart';
import '../models/searchmodel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel _searchModel = SearchModel();


  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      appBarBackgroundColor: blue,
      firestoreCollectionName: 'products',
      searchBy: 'name',
      scaffoldBody: Center(),
      dataListFromSnapshot: _searchModel.dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<SearchModel>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final SearchModel data = dataList[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Card(
                        child: ListTile(
                          subtitle: Text(data.price.toString() + '\$' ,
                            style: TextStyle(color: Colors.lightGreenAccent),),
                          leading: CircleAvatar(
                            backgroundColor: blue,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: data.imageProduct.toString().isNotEmpty ?
                              Image.network(data.imageProduct.toString(),
                                fit: BoxFit.contain,)
                                  : Image.asset('assets/img.png',fit: BoxFit.fill,),
                            ),
                            radius: 25,
                          ),

                          title: Text(data.name.toString(),style: TextStyle(fontSize: 15,color: white),),
                          // subtitle: Text(DateFormat('yyyy_mm_dd').format(DateTime.now()).toString()),
                        ),
                        color: blue,
                      ),
                    ),
                  ],
                );
              });
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
    );
  }
}
