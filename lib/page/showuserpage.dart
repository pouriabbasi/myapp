import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/globalvar.dart';
import '../widgets/textfield.dart';

class ShowUserPage extends StatefulWidget {


  @override
  State<ShowUserPage> createState() => _ShowUserPageState();


}

class _ShowUserPageState extends State<ShowUserPage> {
  QuerySnapshot? user;

  TextEditingController _emailController=TextEditingController();
  TextEditingController _phoneNumberController=TextEditingController();
  TextEditingController _ageController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _familyController=TextEditingController();
  TextEditingController _imageProfileUrlController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _businessController=TextEditingController();
  TextEditingController _userAddedController=TextEditingController();
  TextEditingController _genderController=TextEditingController();
  List<String> dropDownMenuValue=['Gender','Male','Female','Another'];
  String? value = 'Gender';
  String? imageUrl;

  informationUser(){
    CollectionReference reference = FirebaseFirestore.instance.collection('users');
    reference.where('uId',isEqualTo: userUId).get().then((result){
      user=result;
      setState(() {
        _nameController.text=user!.docs[0].get('name');
        _familyController.text=user!.docs[0].get('family');
        _phoneNumberController.text=user!.docs[0].get('phoneNumber');
        _ageController.text=user!.docs[0].get('age').toString();
        _genderController.text = user!.docs[0].get('gender');
        _addressController.text=user!.docs[0].get('address');
        _businessController.text=user!.docs[0].get('business');
        _emailController.text=user!.docs[0].get('email');
        _imageProfileUrlController.text=user!.docs[0].get('imageUrl');
        imageUrl = user!.docs[0].get('imageUrl');
        _passwordController.text=user!.docs[0].get('password');
        // _userAddedController.text=DateTime.parse(DateFormat('yyyy-MM-dd').format(user!.docs[0].get('userAdded').toDate())).toString();
        // _genderController.text=user!.docs[0].get('gender');
        // widget.imageUrl=user!.docs[0].get('imageUser');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    informationUser();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: blue,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    blue,
                    deepBlue,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                CircleAvatar(
                  radius: 40,
                  child: imageUrl!.isNotEmpty ?
                      CircleAvatar(
                        radius: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child:  Container(
                            child: Image.network(imageUrl!,),
                          )
                        ),
                      )
                  :
                      Image.asset('shop+shopping+store+icon-1320191097413967934_512.png',width: 100,height: 100,),
                ),
                Text('Id: ${user!.docs[0].get('uId')}',style: TextStyle(fontSize: 14,color: white),),
                Text('Date of register: ${DateTime.parse(DateFormat('yyyy-MM-dd').format(user!.docs[0].get('userAdded').toDate())).toString()}',
                  style: TextStyle(fontSize: 14,color: white),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Family',
                        labelText: 'Family',
                        controler: _familyController,
                        suffixIcon: Icon(Icons.person),
                        isobsecure: false,
                      ),
                    ),

                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Name',
                        labelText: 'Name',
                        controler: _nameController,
                        suffixIcon: Icon(Icons.person),
                        isobsecure: false,
                      ),
                    ),
                  ],
                ),
                CustomTextFromField(
                  enable: false,
                  hintText: 'Email',
                  labelText: 'Email',
                  controler: _emailController,
                  suffixIcon: Icon(Icons.email),
                  isobsecure: false,
                  inputType: TextInputType.emailAddress,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Phone Number',
                        labelText: 'Phone Number',
                        controler: _phoneNumberController,
                        suffixIcon: Icon(Icons.phone),
                        inputType: TextInputType.number,
                        isobsecure: false,
                      ),
                    ),
                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Age',
                        labelText: 'Age',
                        controler: _ageController,
                        suffixIcon: Icon(Icons.numbers),
                        inputType: TextInputType.number,
                        isobsecure: false,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                CustomTextFromField(
                  enable: false,
                  hintText: 'Gender',
                  labelText: 'Gender',
                  controler: _genderController,
                  suffixIcon: Icon(Icons.transgender),
                  isobsecure: false,
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Business',
                        labelText: 'Business',
                        controler: _businessController,
                        suffixIcon: Icon(Icons.shop),
                        inputType: TextInputType.number,
                        isobsecure: false,
                      ),
                    ),
                    Expanded(
                      child: CustomTextFromField(
                        enable: false,
                        hintText: 'Image link',
                        labelText: 'Image link',
                        controler: _imageProfileUrlController,
                        suffixIcon: Icon(Icons.link),
                        inputType: TextInputType.number,
                        isobsecure: false,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10,),
                // Expanded(
                //   child: CustomTextFromField(
                //     enable: false,
                //     hintText: 'Date of create account',
                //     labelText: 'Date of create account',
                //     controler: _userAddedController,
                //     suffixIcon: Icon(Icons.more_time),
                //     inputType: TextInputType.number,
                //     isobsecure: false,
                //   ),
                // ),
                SizedBox(height: 10,),
                CustomTextFromField(
                  isobsecure: false,
                  enable: false,
                  hintText: 'Address',
                  labelText: 'Address',
                  controler: _addressController,
                  suffixIcon: Icon(Icons.location_on),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
