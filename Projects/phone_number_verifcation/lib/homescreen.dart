import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authprovider.dart';
import 'Button.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<authprovider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  width: 400,
                ),
                Text(
                  "Please Select your profile ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Radio<int>(
                        value: 1,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        }),
                    Container(
                      height: 100,
                      width: 350,
                      padding: EdgeInsets.all(8.0),
                      child: Text("Shipper\n "
                          "Lorem ipsum dolor sit amet,\n"
                          "consectetur adipiscing",
                      textAlign: TextAlign.left,),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.zero,
                    ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Radio<int>(
                        value: 2,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        }),
            Container(
              height: 100,
              width: 350,
              padding: EdgeInsets.all(8.0),
                child: Text("Transporter\n "
                    "Lorem ipsum dolor sit amet,\n"
                    "consectetur adipiscing",
                  textAlign: TextAlign.left,),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),

              )
              )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 390,
                  height: 56,
                  child: Button(text: "CONTINUE", onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
