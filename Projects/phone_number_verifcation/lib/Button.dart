import 'dart:math';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:  onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          shape: MaterialStateProperty.all<ContinuousRectangleBorder>(ContinuousRectangleBorder()),
        ),
        child: Text(text, style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.white),),
    );
  }
}
