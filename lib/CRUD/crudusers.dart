import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/globalvar.dart';

class UsersCRUD{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register(Map<String,dynamic> data){
    firestore.collection('users').doc(userUId).set(data);
  }

  Future<QuerySnapshot<Map<String,dynamic>>> readAll()async{
    return await firestore.collection('users').orderBy('userAdded',descending: true).get().
    catchError((error){
      print(error);
    });
  }

  Future<void>update(String selectDoc, Map<String,dynamic> newValue)async{
    return await firestore.collection('users').doc(selectDoc).update(newValue);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>getRoll(String id)async{
    return await firestore.collection('users').doc(id).get();
  }
}