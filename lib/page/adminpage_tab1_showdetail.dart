import 'package:flutter/material.dart';

import '../CRUD/crudusers.dart';
import '../models/globalvar.dart';
import '../widgets/buttonwidget.dart';
import '../widgets/loadingalertdialog.dart';

class AdminPage_Tab1_ShowDetail extends StatefulWidget {

  String? uId;
  String? name;
  String? family;
  String? phoneNumber;
  int? age;
  String? gender;
  String? address;
  String? business;
  String? email;
  String? imageUrl;
  String roll;

  @override
  State<AdminPage_Tab1_ShowDetail> createState() => _AdminPage_Tab1_ShowDetailState();

  AdminPage_Tab1_ShowDetail({
    this.uId,
    this.name,
    this.family,
    this.phoneNumber,
    this.age,
    this.gender,
    this.address,
    this.business,
    this.email,
    this.imageUrl,
    required this.roll
});
}

class _AdminPage_Tab1_ShowDetailState extends State<AdminPage_Tab1_ShowDetail> {
  UsersCRUD _usersCRUD=UsersCRUD();

  bool showButton=false;
  late String roll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _usersCRUD.getRoll(widget.uId!).then((value){
      widget.roll=value['roll'].toString();
      roll = value['roll'].toString();
    } );
  }

  var itemDropdownButton=[
    'Admin',
    'Plus',
    'Common'
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: blue,
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10,top: 10),
              child: DropdownButton<String>(
                style: TextStyle(color: white,fontSize: 14),
                dropdownColor: blue,
                borderRadius: BorderRadius.circular(40),
                isDense: true,
                value: widget.roll,
                items: itemDropdownButton.map((String items){
                  return DropdownMenuItem(
                      child: Text(items),
                    value: items,
                  );
                }).toList(),

                onChanged: (String? newRoll){
                  setState(() {
                    if(roll != newRoll){
                      showButton = true;
                    }
                    else{
                      showButton = false;
                    }
                    widget.roll=newRoll!;
                  });
              },),
            ),
            // TextButton(
            //     onPressed: (){
            //       ProductModel pm=ProductModel(
            //         userId: userUId,
            //         description: widget.description,
            //         name: widget.name,
            //         brand: widget.brand,
            //         color: widget.color,
            //         category: widget.category,
            //         expiration: widget.expiration,
            //         imageProduct: widget.imageProduct,
            //         material: widget.material,
            //         model: widget.material,
            //         price: widget.price,
            //         timeProduct: widget.timeProduct,
            //         timeAddProduct: widget.timeAddProduct,
            //       );
            //       showDialogForUpdateProduct(context,pm,widget.id!).then((_) {
            //         showDialog(context: context, builder: (context){
            //           return LoadingAlertDialog(message: 'Please Wait...',);
            //         });
            //         Navigator.of(context).pushReplacementNamed('/PageNavigatorBottomNavigator');
            //       }
            //       );
            //     },
            //     child: Padding(padding: EdgeInsets.all(10),
            //       child: Icon(Icons.update,color: Colors.white,),)
            // ),
          ],
          title: Text(widget.name.toString(),
            style: TextStyle(color: Colors.white,fontSize: 22.5,fontWeight: FontWeight.bold),),
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Image.network(widget.imageUrl.toString(),fit: BoxFit.fill,),
                ),
                Wrap(
                  children: [
                    Text('Name:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.name!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Family:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.family!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Age:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.age!.toString(),style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Phone Number:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.phoneNumber.toString().padLeft(3),style: TextStyle(fontSize: 14),),
                    Text('Email:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.email.toString().padLeft(3),style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Gender:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.gender!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Address:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.address!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('Business:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.business!,style: TextStyle(fontSize: 14),),
                    SizedBox(width: 30,),
                    Text('ImageUrl:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.imageUrl!,style: TextStyle(fontSize: 14),),
                    Text('Roll:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.roll,style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  children: [
                    Text('userId:',style: TextStyle(fontSize: 14),),
                    SizedBox(width: 20,),
                    Text(widget.uId.toString(),style: TextStyle(fontSize: 14),),
                  ],
                ),
                showButton == false ?
                    Text('') :
                Container(
                  width: 100,
                  height: 40,
                  child: CustomButton(
                      text: 'Save Change',
                      onClicked: (){
                        _usersCRUD.update(widget.uId!, {
                          'roll':widget.roll
                        }).then((value){
                          showButton = false;
                        });

                      }),
                ),
                // Row(
                //   children: [
                //     Text('id:',style: TextStyle(fontSize: 14),),
                //     SizedBox(width: 20,),
                //     Text(widget.id!,style: TextStyle(fontSize: 14),),
                //   ],
                // )
              ],
            ),
          ),
        )
    );
  }
}
