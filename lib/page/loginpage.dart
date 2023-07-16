import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/login_controller.dart';
import '../models/globalvar.dart';
import '../widgets/pagenavigatorbottomnavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/textfield.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: lightBlue,
            appBar: AppBar(title: Text('ShopCenter',style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),
            ),
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
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 70,vertical: 30),
                        child: Image.asset('assets/shop+shopping+store+icon-1320191097413967934_512.png',width: 100,height: 100,)
                    ),
                    SizedBox(height: 30,),
                    CustomTextFromField(hintText: 'Email',
                      suffixIcon: Icon(Icons.email),
                      isobsecure: false,
                      inputType: TextInputType.phone,
                      controler: controller.emailController,
                    ),
                    CustomTextFromField(hintText: 'Password',
                      suffixIcon: Icon(Icons.password),
                      isobsecure: true,
                      inputType: TextInputType.visiblePassword,
                      controler: controller.passwordController,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: white
                        ),
                        onPressed: (){
                          // Navigator.of(context).pushNamed('/PageNavigatorBottomNavigator');
                          controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty ?
                          controller.login() :
                          Fluttertoast.showToast(
                              msg: 'Please fill the field',
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP
                          );
                        },
                        child: Text('Sign In',
                          style: TextStyle(backgroundColor: white,
                            color: Colors.black,
                            fontSize: 22,
                            height: 2.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                        onPressed: (){
                          Get.toNamed('/RegisterPage');
                        },
                        child: Text('Do you have any account?',style: TextStyle(color: white),)),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
