
import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../CRUD/crudproducts.dart';
import '../models/productmodel.dart';
import '../widgets/buttonwidget.dart';

Future<void> showDialogForUpdateProduct(BuildContext context , ProductModel productModel, String id) async{
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return ShowDialogForUpdateProduct(
          id: id,
          description: productModel.description,
          name: productModel.name,
          brand: productModel.brand,
          model: productModel.model,
          categoryId: productModel.categoryId,
          color: productModel.color,
          expiration: productModel.expiration,
          price: productModel.price,
          count: productModel.count,
          imageProduct: productModel.imageProduct,
          material: productModel.material,
          timeProduct: productModel.timeProduct,
        );
      }
  );
}

class ShowDialogForUpdateProduct extends StatefulWidget {

  final String? id;

  ShowDialogForUpdateProduct({this.id, this.name, this.model, this.brand,this.count,
      this.price, this.material, this.color, this.categoryId,this.categoryName, this.timeProduct,
      this.expiration, this.timeAddProduct, this.imageProduct,this.description});

  final String? description;
  final String? name;
  final String? model;
  final String? brand;
  final int? price;
  final int? count;
  final String? material;
  final String? color;
  final String? categoryId;
  final String? categoryName;
  final DateTime? timeProduct;
  final DateTime? expiration;
  final DateTime? timeAddProduct;
  final String? imageProduct;
  // final File? pictureFile;
  // UserModel? user=UserModel();
  // List<UserModel> users=[]; for n:m relation

  @override
  State<ShowDialogForUpdateProduct> createState() => _ShowDialogForUpdateProductState();
}

class _ShowDialogForUpdateProductState extends State<ShowDialogForUpdateProduct> {
  DateTime? dateProduct;
  DateTime? dateExpiration;
  final  _formState = GlobalKey<FormState>();
// File? file;
  String? tst;
  String? imageUrl;
  bool enableButtonUpdate=true;
  bool enableButtonCancel=false;
  final ProductCRUD _productCRUD=ProductCRUD();
  TextEditingController nameController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController modelController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController materialController=TextEditingController();
  TextEditingController colorController=TextEditingController();
  TextEditingController categoryNameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController imageProductController=TextEditingController();
  TextEditingController countController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name!;
    brandController.text = widget.brand!;
    modelController.text = widget.model!;
    priceController.text = widget.price!.toString();
    materialController.text = widget.material!;
    colorController.text = widget.color!;
    categoryNameController.text = widget.categoryName!;
    descriptionController.text=widget.description!;
    dateProduct=widget.timeProduct;
    dateExpiration=widget.expiration;
    countController.text=widget.count.toString();

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // key: _scaffoldKey,
      scrollable: true,
      title: Text('Update product',style: TextStyle(letterSpacing: 2,fontSize: 22,fontWeight: FontWeight.bold),),
      content:
      Form(
        key: _formState,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Name'
              ),
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Model'
              ),
              controller: modelController,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Brand'
              ),
              controller: brandController,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Price'
              ),
              controller: priceController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Count'
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
            TextField(
              decoration: InputDecoration(
                  hintText: 'Category'
              ),
              controller: categoryNameController,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Description'
              ),
              controller: descriptionController,
            ),
            SizedBox(height: 10,),
            CustomButton(text: dateProduct == null ? 'Select date product' : DateFormat('yyyy/MM/dd').format(dateProduct!),
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

            // CustomButton(text: 'Upload Picture', onClicked: (){
            //   setState((){
            //     uploadPicture();
            //   });
            // }),
          ],
        ),
      ),
      actions: [
        enableButtonCancel == false ?
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'))
            :
        ElevatedButton(onPressed: (){}, child: Text('Cancel'),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        ),
        enableButtonUpdate == false ?
        ElevatedButton(onPressed: (){}, child: Text('Update'),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
        )
            :
        ElevatedButton(
            onPressed: ()async{
              Map<String,dynamic> data={
                'name': nameController.text.trim(),
                'model': modelController.text.trim(),
                'brand': brandController.text.trim(),
                'price': int.parse(priceController.text.trim()),
                'category': categoryNameController.text,
                'color': colorController.text,
                'count':countController.text,
                // 'imageProduct': imageUrl,
                'material': materialController.text,
                // timeAddProduct: DateTime.now(),
                'timeProduct': dateProduct,
                'description' :descriptionController.text,
                'expiration': dateExpiration,
              };

              // ProductModel pm=ProductModel(
              //     userId: userUId,
              //     name: nameController.text.trim(),
              // model: modelController.text.trim(),
              // brand: brandController.text.trim(),
              // price: int.parse(priceController.text.trim()),
              // category: categoryController.text,
              // color: colorController.text,
              // // 'imageProduct': imageUrl,
              // material: materialController.text,
              // // timeAddProduct: DateTime.now(),
              // timeProduct: dateProduct,
              // description:descriptionController.text,
              // expiration: dateExpiration,
              // );
              _productCRUD.updateProduct(widget.id!,data).then((value) {
                print('Success Update Data!');
                Navigator.of(context).pushNamed('/PageNavigatorBottomNavigator');
              });
              Navigator.pop(context);
            }, child: Text('Update')
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

  uploadPicture(){
    var input=FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs=FirebaseStorage.instance;
    enableButtonCancel = true;
    input.click();
    input.onChange.listen((event) {
      final file=input.files!.first;
      var reader=FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async{
        var snapshot = await fs.ref().child(file.name).putBlob(file);
        String downloadUrl =await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl.toString();
        });
        print(downloadUrl);
        print('Image Url : ${imageUrl}');
        if(imageUrl !=null){
          setState(() {
            enableButtonUpdate = true;
            enableButtonCancel = false;
          });
        }

      });
    });
  }
}
