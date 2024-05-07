import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  VoidCallback buttonPressed;

  MyButton({super.key, required this.buttonName, required this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: buttonPressed,
        color: Colors.orange[200],
        elevation: 0,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(buttonName),
        ),
      );
  }
}
