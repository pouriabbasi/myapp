import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CRUD/crudshopcard.dart';
import '../controller/shopcard_controller.dart';

class ShopCardPage extends GetView<ShopCardController> {
  ShopCardPage({Key? key}) : super(key: key);
  ShopCardCRUD _cardCRUD=ShopCardCRUD();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: Get.height,
          minWidth: Get.width,
        ),
        child: StreamBuilder(
          stream: _cardCRUD.loadProductsDataAsSnapshot(),
          builder: (context,snapshot){
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Card();
              },
            );
          },
        ),
      ),
    );
  }
}
