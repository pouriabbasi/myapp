
import 'package:myapp/models/productmodel.dart';


class ShopCardModel{

  final DateTime? timeBought;
  final List<String>? productsId;
  final int? count;
  final String? userId;
  final List<ProductModel>? productModel;
  ShopCardModel({this.productsId, this.timeBought, this.count, this.userId, this.productModel});

}