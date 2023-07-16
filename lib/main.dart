import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/page/adminpage.dart';
import 'package:myapp/page/homepage.dart';
import 'package:myapp/page/loginpage.dart';
import 'package:myapp/page/registerpage.dart';
import 'package:myapp/page/searchpage.dart';
import 'package:myapp/page/shopcardpage.dart';
import 'package:myapp/page/showdialogforaddproduct.dart';
import 'package:myapp/page/showuserpage.dart';
import 'package:myapp/page/splashpage.dart';
import 'package:myapp/widgets/pagenavigatorbottomnavigator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shelf_proxy/shelf_proxy.dart';

import 'bindings.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb==true){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAjWXj3tO1OSUCexKMb7I5xHvqjoeeRCUg",
            authDomain: "myapp-1c11b.firebaseapp.com",
            databaseURL: "https://myapp-1c11b-default-rtdb.firebaseio.com",
            projectId: "myapp-1c11b",
            storageBucket: "myapp-1c11b.appspot.com",
            messagingSenderId: "315239312737",
            appId: "1:315239312737:web:ac2369a2896f6b543c6920",
            measurementId: "G-W60SVMC0FC"
        )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/SplashPage',
      initialBinding: MyBinding(),
      getPages: [
        GetPage(name: '/SearchPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: SearchPage()),),
        GetPage(name: '/SplashPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: SplashPage())),
        GetPage(name: '/RegisterPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: RegisterPage())),
        GetPage(name: '/LoginPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: LoginPage())),
        GetPage(name: '/HomePage', page: ()=> Directionality(textDirection: TextDirection.rtl,child: HomePage())),
        GetPage(name: '/PageNavigatorBottomNavigator', page: ()=>const Directionality(textDirection: TextDirection.rtl,child: PageNavigatorBottomNavigator())),
        GetPage(name: '/ShowProductPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: ShowDialogForAddProduct())),
        GetPage(name: '/ShowUserPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: ShowUserPage())),
        GetPage(name: '/AdminPage', page: ()=>Directionality(textDirection: TextDirection.rtl,child: AdminPage())),
        GetPage(name: '/ShopCardPage', page: ()=>Directionality(textDirection: TextDirection.rtl, child: ShopCardPage())),
      ],
      // routes: {
      //   '/SplashPage':(context)=>Directionality(textDirection: TextDirection.rtl,child: SplashPage(),),
      //   '/RegisterPage':(context)=>Directionality(textDirection: TextDirection.rtl,child: RegisterPage(),),
      //   '/LoginPage':(context)=>Directionality(textDirection: TextDirection.rtl, child: LoginPage()),
      //   '/HomePage':(context)=>Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      //   '/PageNavigatorBottomNavigator':(context)=>
      //       Directionality(textDirection: TextDirection.rtl, child: PageNavigatorBottomNavigator()),
      //   '/ShowProductPage': (context)=>Directionality(textDirection: TextDirection.rtl, child: ShowDialogForAddProduct()),
      //   '/ShowUserPage':(context)=>Directionality(textDirection: TextDirection.rtl, child: ShowUserPage()),
      //   '/AdminPage' : (context)=>Directionality(textDirection: TextDirection.rtl, child: AdminPage()),
      // },
      theme: ThemeData(
        primaryColor: Colors.grey[900],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
