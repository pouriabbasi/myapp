import 'package:get/get.dart';

import 'controller/login_controller.dart';
import 'controller/splash_controller.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
  }

}