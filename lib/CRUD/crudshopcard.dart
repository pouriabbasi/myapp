
import 'package:cloud_firestore/cloud_firestore.dart';

import 'crudproducts.dart';

class ShopCardCRUD{
  FirebaseFirestore _fireStore=FirebaseFirestore.instance;
  ProductCRUD _productCRUD=ProductCRUD();
  
Future<String?> buy(String productId)async{
  DocumentSnapshot documentSnapshot =await _fireStore.collection('products').doc(productId).get();
  bool isBought = documentSnapshot.get('isBought');
  int count = documentSnapshot.get('count');
  if(isBought==true && count==0){
    return "this have bought or out of count";
  }else{
    _productCRUD.updateProduct(productId, {'count':count-1});
    return 'you have bought that';
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> loadProductsDataAsSnapshot(){
  return _fireStore.collection('shopCards').where('addedToShopCard',isEqualTo: true).snapshots();
}
}