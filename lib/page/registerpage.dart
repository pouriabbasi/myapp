import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../CRUD/crudusers.dart';
import '../models/globalvar.dart';
import '../models/usermodel.dart';
import '../widgets/erroralertdialog.dart';
import '../widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _phoneNumberController=TextEditingController();
  TextEditingController _ageController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _registerPasswordController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _familyController=TextEditingController();
  TextEditingController _imageProfileController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _businessController=TextEditingController();
  List<String> dropDownMenuValue=['Another','Male','Female',];
  String? value = 'Another';


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey,
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
                  Image.asset('assets/shop+shopping+store+icon-1320191097413967934_512.png',width: 100,height: 100,),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFromField(
                          controler: _nameController,
                          hintText: 'Name',
                          suffixIcon: Icon(Icons.person),
                          isobsecure: false,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFromField(
                          controler: _familyController,
                          hintText: 'Family',
                          suffixIcon: Icon(Icons.person),
                          isobsecure: false,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFromField(
                    controler: _emailController,
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    isobsecure: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextFromField(
                    controler: _passwordController,
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.pin),
                    isobsecure: true,
                  ),
                  CustomTextFromField(
                    controler: _registerPasswordController,
                    hintText: 'RegisterPassword',
                    suffixIcon: Icon(Icons.pin),
                    isobsecure: true,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFromField(
                          controler: _phoneNumberController,
                          hintText: 'Phone Number',
                          suffixIcon: Icon(Icons.phone),
                          inputType: TextInputType.number,
                          isobsecure: false,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFromField(
                          controler: _ageController,
                          hintText: 'Age',
                          suffixIcon: Icon(Icons.numbers),
                          inputType: TextInputType.number,
                          isobsecure: false,
                        ),
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    style: TextStyle(color: white),
                    dropdownColor: lightBlue,
                    value: value,
                    onChanged: (newVal){
                      setState(() {
                        value=newVal!;
                      });
                    },
                    items: dropDownMenuValue.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFromField(
                          controler: _businessController,
                          hintText: 'Sey your Business',
                          suffixIcon: Icon(Icons.shop),
                          inputType: TextInputType.number,
                          isobsecure: false,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFromField(
                          controler: _imageProfileController,
                          hintText: 'Image link',
                          suffixIcon: Icon(Icons.link),
                          inputType: TextInputType.number,
                          isobsecure: false,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFromField(
                    isobsecure: false,
                    controler: _addressController,
                    hintText: 'Address',
                    suffixIcon: Icon(Icons.location_on),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: (){
                         _register();
                        // Navigator.of(context).pushNamed('/LoginPage');
                      },
                      child: Text('SignUp',
                        style: TextStyle(backgroundColor: Colors.blue,
                            color: Colors.white,
                            fontSize: 20,
                            height: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveUserData(){
    // Map<String,dynamic>userData={
    //   'username':_nameController.text.trim(),
    //   'name':_nameController.text.trim(),
    //   'uId':userId,
    //   'userNumber':_phoneConfigController.text.trim(),
    //   'imgPro':_imageProfileController.text.trim(),
    //   'time':DateTime.now(),
    //   'address':_addressController.text,
    // };
    UserModel user=new UserModel(
      uId: userUId,
      name: _nameController.text.trim(),
      family:_familyController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      phoneNumber: _phoneNumberController.text.trim(),
      imageUrl: _imageProfileController.text,
      address: _addressController.text,
      business: _businessController.text,
      email: _emailController.text.trim(),
      gender: value,
      password: _passwordController.text.trim(),
      userAdded: DateTime.now().toLocal(),
      roll: 'Common'
    );
    // DocumentReference reference= FirebaseFirestore.instance.collection('users').doc(userUId);
    // reference.set(user.tojson());
    UsersCRUD usersCRUD=UsersCRUD();
    usersCRUD.register(user.tojson());
  }

  void _register()async{
     User? currentUser;
    if(_passwordController.text.trim()==_registerPasswordController.text.trim()){
      await _auth.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim()
      ).then((value) {
        currentUser=value.user;
        userUId=currentUser!.uid;
        userEmail=currentUser!.email;
        getUserName=_emailController.text.trim();
        saveUserData();
      }).catchError((error){
         // Navigator.pop(context);
        showDialog(context: context,
            builder: (context){
          return ErrorAlertDialog(
            message: error.message.toString(),
          );
        });
      });
      if(currentUser != null){
        Navigator.of(context).pushNamed('/LoginPage');
      }else{

      }
    }else{
      Fluttertoast.showToast(msg: 'Please check your password or password config',
      fontSize: 20,
        gravity: ToastGravity.TOP_LEFT
      );
    }
  }
}
