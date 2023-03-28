
import 'package:first_api/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
 final controller;
 final VoidCallback onSave;
 final VoidCallback onCancel;


   DialogBox({Key? key,
     this.controller,
     required this.onCancel,
     required this.onSave,
   }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow[300],
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //get user input
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                hintText: 'Add a new task',
                ),
              ),

              //buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                //save button
             MyButton(text: 'Save', onPressed: onSave),

              const SizedBox(width: 8,),
              //cancel button
             MyButton(text: 'Cancel', onPressed: onCancel),

              ],)
            ],
          ),
        ),
      );
   }
}
