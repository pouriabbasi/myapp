import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../CRUD/crudusers.dart';
import '../models/globalvar.dart';
import '../widgets/erroralertdialog.dart';
import '../widgets/loadingalertdialog.dart';

class LoginController extends GetxController{
  Rx<UsersCRUD> usersCRUD=UsersCRUD().obs;

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> login()async{
    Get.dialog(LoadingAlertDialog(message:'Please Wait'));
    User? currentUser;
    await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth) {
      currentUser = auth.user;
      userUId=currentUser!.uid;
      usersCRUD.value.getRoll(userUId).then((value){
        userRoll=value['roll'].toString();
        print(userRoll);
      });
    }).catchError((error){
      Get.back();
      Get.dialog(ErrorAlertDialog(message: error.message.toString(),));
    });
    if(currentUser!=null){
      Timer(Duration(seconds: 1), (){
        Get.dialog(LoadingAlertDialog(message:'Please Wait'));
        Get.back();
       Get.offNamed('/PageNavigatorBottomNavigator');
      });
    }else{
      print('error!');
    }
  }

}