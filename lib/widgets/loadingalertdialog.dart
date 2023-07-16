import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatefulWidget {
   LoadingAlertDialog({Key? key,this.message}) : super(key: key);
  String? message;
  @override
  _LoadingAlertDialogState createState() => _LoadingAlertDialogState();
}

class _LoadingAlertDialogState extends State<LoadingAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        scrollable: true,
        actions: [
          Center(child: CircularProgressIndicator(),),
          Center(child: Text(widget.message!),),
        ],
      ),
    );
  }
}
