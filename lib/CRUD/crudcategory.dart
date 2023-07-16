import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCRUD{

  Stream<QuerySnapshot<Object?>> getStreamCategories(){
    // var a="💕💕🤣🤣🤣🤣😍👍👍🙌🙌👍😁 windows+.";
    return FirebaseFirestore.instance.collection('category').snapshots();
  }
}