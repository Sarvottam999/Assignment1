// error_dialog.dart

import 'package:flutter/material.dart';
   CustomAlertBox (BuildContext context, String text ) {
  return showDialog(

    context: context,
    builder: (BuildContext context) {
      return  Dialog(
        backgroundColor:const  Color.fromARGB(255, 255, 255, 255),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    // color: Colors.white,
    height: 300.0,
    width: 300.0,
   
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:const   EdgeInsets.all(15.0),
          child: Text(text, style:const  TextStyle(color: Colors.red, fontSize: 15),),
        ),
       
        const Padding(padding: EdgeInsets.only(top: 50.0)),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        },
            child:const  Text('OK!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
      ],
    ),
  ),
);
    },
  );
}