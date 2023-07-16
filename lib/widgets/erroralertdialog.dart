import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatefulWidget {
   ErrorAlertDialog({Key? key,this.message}) : super(key: key);
  String? message;
  @override
  _ErrorAlertDialogState createState() => _ErrorAlertDialogState();
}

class _ErrorAlertDialogState extends State<ErrorAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        scrollable: true,
        actions: [
          Center(child: Text(widget.message!,style: TextStyle(fontSize: 20),),)
        ],
      ),
    );
  }
}
