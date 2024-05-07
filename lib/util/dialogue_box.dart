import 'package:app1/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSaved;
  VoidCallback onCancelled;

  DialogueBox(
      {super.key,
      required this.controller,
      required this.onSaved,
      required this.onCancelled});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
          height: 170,
          width: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add new task.."),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(buttonName: "Save", buttonPressed: onSaved),
                  const SizedBox(
                    width: 60,
                  ),
                  MyButton(buttonName: "Cancel", buttonPressed: onCancelled)
                ],
              )
            ],
          )),
    );
  }
}
