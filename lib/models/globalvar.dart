import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/usermodel.dart';

import '../widgets/erroralertdialog.dart';

int lastId = 0;
String userUId='';
String userRoll='';
String? userEmail = "";
String? userImageUrl = "";
String? getUserName = "";
String? adUserName = "";
String? adUserImageUrl = "";




Color deepBlue = Color.fromRGBO(0,51,153,1);
Color blue = Color.fromRGBO(51,102,204,1);
Color lightBlue = Color.fromRGBO(1,153,255,1);
Color white = Color.fromRGBO(255, 255, 255, 1);

class Global {


  static bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserModel?> theUserWhenLoggedIn() async {
    if (isLoggedIn()) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUId)
          .get()
          .then((value) {
        return UserModel.fromjson(value.data()!);
      }).catchError((error) {
        ErrorAlertDialog(message: error.message.toString());
      });
    }
    return null;
  }

  static Future<PlatformFile> selectFile() async{
    PlatformFile pickedFile;
    FilePickerResult? result =await FilePicker.platform.pickFiles(allowMultiple: false);
    // if(result == null) return;
    pickedFile= result!.files.single;
    // Get.snackbar('${result.files.first.name}', '${result.files.first.runtimeType}');
    return pickedFile;
  }
  static Future<String> uploadImage(Uint8List? file , String fileName)async{
    UploadTask uploadTask;
    var urlDownload;

      final ref = FirebaseStorage.instance.ref().child('images/${fileName}');
      uploadTask=ref.putData(file!);
      final snapshot=await uploadTask.whenComplete(() => null);
      urlDownload =await snapshot.ref.getDownloadURL();
      print(urlDownload);

    return urlDownload;
  }
  // static UploadTask? uploadFile(String destination , File file){
  //   try{
  //     final refrence = FirebaseStorage.instance.ref(destination);
  //     return  refrence.putFile(file);
  //   }on FirebaseException catch (error){
  //     return null;
  //   }
  //
  // }
  List<int>idx=[1,2,3];

  Color? ChangeColorCard(){
    int i=idx.length;
    Color? color;

    if(i==3){
      idx.remove(idx.last);
      return color=Colors.blueAccent;
    }else if(i==2){
      idx.remove(idx.last);
      return color=Colors.cyan;
    }else{
      idx.add(2);
      idx.add(3);
      return color=Colors.cyanAccent;
    }
  }

}
