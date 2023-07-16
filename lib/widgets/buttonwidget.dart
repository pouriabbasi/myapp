import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key ,required this.text , required this.onClicked}) : super(key: key);
  String text;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: FittedBox(
          child: Text(
              text,
            style: TextStyle(fontSize: 15,color: Colors.black),
          ),
        ),
    );
  }
}

