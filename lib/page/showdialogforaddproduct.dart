
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../CRUD/crudcategory.dart';
import '../CRUD/crudproducts.dart';
import '../models/globalvar.dart';
import '../models/productmodel.dart';
import '../widgets/buttonwidget.dart';


Future<void> showDialogForAddProduct(BuildContext context) async{
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return ShowDialogForAddProduct();
      }
  );
}
class ShowDialogForAddProduct extends StatefulWidget {
  const ShowDialogForAddProduct({Key? key}) : super(key: key);


  @override
  _ShowDialogForAddProductState createState() => _ShowDialogForAddProductState();
}

class _ShowDialogForAddProductState extends State<ShowDialogForAddProduct> {

  DateTime? dateProduct;
  DateTime? dateExpiration;
  final  _formState = new GlobalKey<FormState>();
// File? file;
  String? tst;
  String? imageUrl;
  bool enableButtonAdd=false;
  bool enableButtonCancel=true;
  ProductCRUD _productCRUD=ProductCRUD();
  CategoryCRUD _categoryCRUD = CategoryCRUD();
  TextEditingController nameController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController modelController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController materialController=TextEditingController();
  TextEditingController colorController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  TextEditingController timeProductController=TextEditingController();
  TextEditingController expirationController=TextEditingController();
  TextEditingController imageProductController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController countController=TextEditingController();
  String? value;
  String? categoryId;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    brandController.dispose();
    modelController.dispose();
    priceController.dispose();
    materialController.dispose();
    colorController.dispose();
    categoryController.dispose();
    timeProductController.dispose();
    expirationController.dispose();
    imageProductController.dispose();
    descriptionController.dispose();
    countController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // key: _scaffoldKey,
      scrollable: true,
      title: Text('Add product',style: TextStyle(letterSpacing: 2,fontSize: 22,fontWeight: FontWeight.bold),),
      content:
      Form(
        key: _formState,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Name'
              ),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Model'
              ),
              controller: modelController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'brand'
              ),
              controller: brandController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'price'
              ),
              controller: priceController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'count'
              ),
              controller: countController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Material'
              ),
              controller: materialController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Color'
              ),
              controller: colorController,
            ),
            // TextField(
            //   decoration: InputDecoration(
            //       hintText: 'Category'
            //   ),
            //   controller: categoryController,
            // ),
            StreamBuilder<QuerySnapshot>(
                stream: _categoryCRUD.getStreamCategories(),
                builder: (BuildContext context , snapshot){
                  if(!snapshot.hasData){
                    return Center(child: Text("loading"));
                  }
                  else{
                    List<DropdownMenuItem<String?>> dropDownMenuValue = [];

                    for(int i=0;snapshot.data!.docs.length>i;i++ ){
                      String val=snapshot.data!.docs[i]['categoryName'];
                      String catId=snapshot.data!.docs[i].id;
                      categoryId=catId;
                      dropDownMenuValue.add(
                          DropdownMenuItem(
                              child: Text(val,style: TextStyle(color: Colors.black),),
                              value: "${val}"
                          )
                      );
                    }
                    return DropdownButton<String?>(
                      items: dropDownMenuValue,
                      borderRadius: BorderRadius.circular(20),
                      style: TextStyle(color: Colors.black),
                      dropdownColor: lightBlue,
                      value: value,
                      onChanged: (newVal){
                        setState(() {
                          value=newVal!;
                        });
                      },
                      isExpanded: false,
                    );
                  }
                }
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Description'
              ),
              controller: descriptionController,
            ),
            SizedBox(height: 10,),
            CustomButton(text: dateProduct == null ? 'Select Date Product' : DateFormat('yyyy/MM/dd').format(dateProduct!),
                onClicked: (){
              setState(() {
                pickDateProduct(context);
              });
            }),
            SizedBox(height: 10,),
            CustomButton(text: getTextExpiration(), onClicked: (){
              setState(() {
                pickDateExpiration(context);
              });
            }),
            SizedBox(height: 10,),
            // CustomButton(text: 'Select File', onClicked: ()async{
            //   file =await Global.selectFile();
            // }),
            CustomButton(text: 'Upload Picture', onClicked: (){
                // uploadPicture();
                Global.selectFile().then((value) {
                  if(value.isBlank == true){
                    Get.snackbar('Empty!' , 'Please select a picture');
                    setState(() {
                      enableButtonAdd = false;
                      enableButtonCancel = true;
                    });
                  }else{
                    setState(() {
                      enableButtonAdd = false;
                      enableButtonCancel = false;
                    });
                    Global.uploadImage(value.bytes, value.name).then((value) {
                      imageUrl=value;
                      if (imageUrl!.isNotEmpty) {
                        setState(() {
                          enableButtonAdd = true;
                          enableButtonCancel = false;
                        });
                      }
                    }
                    );
                  }
                });

            }),
          ],
        ),
      ),
      actions: [
        enableButtonCancel == true ?
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'))
        :
        ElevatedButton(onPressed: (){}, child: Text('Cancel'),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
        enableButtonAdd == false ?
        ElevatedButton(onPressed: (){}, child: Text('Add'),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        )
            :
        ElevatedButton(
            onPressed: ()async{
              ProductModel pm=ProductModel(
                userId: userUId,
                name: nameController.text.trim(),
                model: modelController.text.trim(),
                brand: brandController.text.trim(),
                count: int.parse(countController.text.trim()),
                price: int.parse(priceController.text.trim()),
                categoryId: categoryId,
                categoryName: value,
                color: colorController.text,
                imageProduct: imageUrl,
                description: descriptionController.text,
                material: materialController.text,
                timeAddProduct: DateTime.now(),
                timeProduct: dateProduct,
                expiration: dateExpiration,
                isBought: false,
                isAccess: false,
                // pictureFile: userImageUrl,
                // expiration: DateTime.parse(expirationController.text),
                // timeProduct: DateTime.parse(timeProductController.text),
              ) ;
              _productCRUD.createProduct(pm).then((value) {
                print('success added data!');
                Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
                Get.snackbar('${nameController.text}','Success added data!');
              }).catchError((error){
                print(error);
              });
              Navigator.pop(context);
            }, child: Text('Add')
        ),
      ],
    );
  }
  Future pickDateProduct(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5), lastDate: DateTime(DateTime.now().year + 5));

    setState(() {
      dateProduct = newDate;
    });


  }

  Future pickDateExpiration(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    setState(() {
      dateExpiration = newDate;
    });

  }

  // String getTextProduct(){
  //   if(dateProduct==null){
  //     return 'Select Date Product';
  //   }else{
  //     return DateFormat('yyyy/MM/dd').format(dateProduct!);
  //   }
  // }

  String getTextExpiration(){
    if(dateExpiration==null){
      return 'Select Date Expiration';
    }else{
      return DateFormat('yyyy/MM/dd').format(dateExpiration!);
    }
  }


  // uploadPicture(){
  //   var input=FileUploadInputElement()..accept = 'image/*';
  //   FirebaseStorage fs=FirebaseStorage.instance;
  //   enableButtonCancel = true;
  //   input.click();
  //   input.onChange.listen((event) {
  //     File file=input.files!.first;
  //     var reader=FileReader();
  //     reader.readAsDataUrl(file);
  //     reader.onLoadEnd.listen((event) async{
  //       var snapshot = await fs.ref().child(file.name).putBlob(file);
  //       String downloadUrl =await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = downloadUrl.toString();
  //       });
  //       print(downloadUrl);
  //       print('Image Url : ${imageUrl}');
  //       if(imageUrl !=null){
  //         setState(() {
  //           enableButtonAdd = true;
  //           enableButtonCancel = false;
  //         });
  //       }
  //
  //     });
  //   });
  // }
}


// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final TextEditingController _textEditingController = TextEditingController();
//
// Future<void> showInformationDialog(BuildContext context) async {
//   return await showDialog(
//       context: context,
//       builder: (context) {
//         bool isChecked = false;
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: _textEditingController,
//                       validator: (value) {
//                         return value!.isNotEmpty ? null : "Enter any text";},
//                       decoration:InputDecoration(hintText: "Please Enter Text")
//                       ,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Choice Box"),
//                         Checkbox(
//                             value: isChecked,
//                             onChanged: (checked) {
//                               setState(() {
//                                 isChecked = checked!;
//                               });
//                             })
//                       ],
//                     )
//                   ],
//                 )),
//             title: Text('Stateful Dialog'),
//             actions: <Widget>[
//               InkWell(
//                 child: Text('OK   '),
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Do something like updating SharedPreferences or User Settings etc.
//                     Navigator.of(context).pop();
//                   }
//                 },
//               ),
//             ],
//           );
//         });
//       });
// }