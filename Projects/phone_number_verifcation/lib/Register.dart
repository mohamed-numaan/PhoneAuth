//Selecting Languages//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:phone_number_verification/Language.dart';
import 'Button.dart';
import 'Language.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(),
                child: Image.asset('assets/image.png'),
              ),
              SizedBox(
                height: 19.27,
                width: 258.33,
              ),
              Text(
                "Please Select Your Language",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 29.49,
                width: 184.45,
              ),
              Text(
                "You can change the language\n"
                "                  at any time",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),

              SizedBox(
                width: 328,
                height: 56,
                child: Button(
                    text: "NEXT",
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Language()));
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
