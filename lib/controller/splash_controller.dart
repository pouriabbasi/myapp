import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  StartTimer(){
    Timer(Duration(seconds: 4),(){
      if(FirebaseAuth.instance.currentUser!=null){
        // Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
        Get.offNamed('/PageNavigatorBottomNavigator');
      }else{
        // Navigator.of(context).pushReplacementNamed('/LoginPage');
        Get.offNamed('/LoginPage');
      }
      // Route newRoute=MaterialPageRoute(builder: (context)=> RegisterPage());
      // Navigator.pushReplacement(context, newRoute);

    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    print('test getx');
    StartTimer();
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

}