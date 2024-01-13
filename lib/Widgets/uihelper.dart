import 'package:flutter/material.dart';

class UiHelper{
   static CustomAlertDialog(BuildContext context,String text){
     showDialog(context: context, builder: (BuildContext context){
       return AlertDialog(
         title: Text(text),
         actions: [
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child: Text("Ok")),
         ],
       );

     }  );

   }

}