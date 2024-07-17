import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:phone_number_verification/UserModel.dart';
import 'package:phone_number_verification/homescreen.dart';
import 'package:phone_number_verification/utils.dart';
import 'authprovider.dart';
import 'package:provider/provider.dart';
import 'Button.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;

  const Otpscreen({super.key, required this.verificationId});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<authprovider>(context, listen: true).isLoading;
    final bool onchanged = false;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true ? const Center(child: CircularProgressIndicator(color: Colors.black12,),):Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextSelectionGestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Icon(Icons.arrow_back)),
              ),
              SizedBox(
                height: 23,
                width: 117,
              ),
              Text(
                "Verify Phone",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 177,
                height: 16,
              ),
              Text(
                "Code is sent to your number",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border(
                      top: BorderSide(color: Colors.blueAccent),
                      left: BorderSide(color: Colors.blueAccent),
                      right: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
                onCompleted: (value){
                  setState(() {
                    otpCode = value;
                    print(otpCode);
                  });
                },
              ),
              SizedBox(
                width: 243,
                height: 16,
              ),
              Text(
                "Didn't receive the code?",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                width: 243,
                height: 16,
              ),
              Text(
                "Request Again",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Button(
                  text: "VERIFY AND CONTINUE",
                  onPressed: () {
                    print(otpCode);
                    if(otpCode != null){
                      VerifyOTP(context, otpCode!);
                    }
                    else{
                      showSnackBar(context, "Enter 6-Digit code");
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void VerifyOTP(BuildContext context, String userOtp) {
    final ap = Provider.of<authprovider>(context, listen: false);
    UserModel userModel = UserModel(PhoneNumber: "");
    ap.VerifyOTP(
      context: context,
      verificaionId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        //checking whether user exits in the db//
        ap.checkExistingUser().then(
          (onValue) async {
            if (onValue == true) {

            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const homescreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
