import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {

  CustomTextFromField({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.isobsecure,
    this.controler,
    this.inputType,
    this.enable,
    this.initialValue,
    this.labelText,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final suffixIcon;
  final bool? isobsecure;
  final bool? enable;
  TextEditingController? controler=TextEditingController();
  TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 19,right: 19,bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white70,
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: inputType,
        enabled: enable,
        controller: controler,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          suffixStyle: TextStyle(color: Colors.red),
          hintStyle: TextStyle(fontSize: 15),
          border: InputBorder.none,
          errorMaxLines: 1,
        ),
        obscureText: isobsecure!,
        style: TextStyle(color: Colors.black,fontSize: 16),
      ),
    );
  }
}
