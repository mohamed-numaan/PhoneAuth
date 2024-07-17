import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:phone_number_verification/UserModel.dart';
import 'package:pinput/pinput.dart';
import 'OTPScreen.dart';
import 'UserModel.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_verification/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OTPScreen.dart';

class authprovider extends ChangeNotifier{

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading  = false;
  bool get isLoading => _isLoading;
  String? _userId;
  String get userId => _userId!;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore= FirebaseFirestore.instance;


  authprovider(){
    checkSign();

  }
  void checkSign() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("is_signedin") ?? false;
    notifyListeners();
  }
  
  Future SetSignIn() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_SignedIn", true);
    _isSignedIn = true;
    notifyListeners();

  }
//signin
  void signinwithphone(BuildContext context, phonenumber) async{
    try{
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredentail)async{
            await _firebaseAuth.signInWithCredential(phoneAuthCredentail);
          },
          verificationFailed: (error){
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken){
             Navigator.push(
                (context), MaterialPageRoute(
                builder: (context)=> Otpscreen(
                verificationId: verificationId)
            ),
            );
      },
          codeAutoRetrievalTimeout: (verificationId){});

    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
    }
  }

  //verift OTP
  void VerifyOTP({
    required BuildContext context,
    required String verificaionId,
    required String userOtp,
    required Function onSuccess,
}) async{
    _isLoading = true;
    notifyListeners();
    
    try{
      PhoneAuthCredential  credential  = PhoneAuthProvider.credential(
          verificationId: verificaionId, smsCode: userOtp);

    User? user = (await _firebaseAuth.signInWithCredential(credential)).user!;
    if(user != null){
      _userId = user.uid;
      onSuccess();
    }
    _isLoading = false;
    notifyListeners();
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
    }

}

//Database
Future<bool>checkExistingUser() async{
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_userId).get();
    if(snapshot.exists){
      print("User Exists");
      return true;
    }else{
      print("New User");
      return false;
    }

  }
void SaveUserDataToFirebase({
    required BuildContext context,
    required File PhoneNumber,
    required UserModel usermodel,

}) async{
    _isLoading = true;
    notifyListeners();
    try{
      await storeFileToStorage("PhoneNumber", PhoneNumber).then((Value){
        usermodel.PhoneNumber = _firebaseAuth.currentUser! .phoneNumber!;
      });


    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
  }
}
Future<String> storeFileToStorage(String ref,File file)async{
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String DownloadURL = await snapshot.ref.getDownloadURL();
    return DownloadURL;
}


//Future saveUserDataToSP() async{
   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //await sharedPreferences.setString("user_model", jsonEncode(UserModel.));
//}//
}



