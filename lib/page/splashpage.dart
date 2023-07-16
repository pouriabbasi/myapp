import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';
import '../models/globalvar.dart';
import '../widgets/animationimage.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      // Colors.cyan,
                      // Colors.lightGreenAccent,
                      blue,
                      deepBlue,
                      lightBlue,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //     width: Get.width/1.1,
                //     height: Get.height/1.1,
                //     margin: EdgeInsets.all(20),
                //     child: Image.asset('assets/shop+shopping+store+icon-1320191097413967934_512.png',),
                // ),
                AnimationImage(),
              ],
            ),
          ),
        ),
    );
  }
}

