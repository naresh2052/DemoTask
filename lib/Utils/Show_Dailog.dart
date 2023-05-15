

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension DailogExtension on BuildContext{

   void showMessageDialog(String msg)async{
     await showDialog(
         context: this,
         builder: (context) {
           return CupertinoAlertDialog(
             title: Text(
               msg,
             ),
             actions: <Widget>[
               CupertinoDialogAction(
                 onPressed: () {
                   Navigator.pop(context);
                 },
                 textStyle: const TextStyle(
                   fontSize: 20,
                   fontWeight:FontWeight.w500,
                 ),
                 child:  const Text('OK',
                   style: TextStyle(
                     color: Colors.indigoAccent,
                   ),
                 ),
               ),
             ],
           );
         });
   }
}