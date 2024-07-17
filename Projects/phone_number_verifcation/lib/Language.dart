//Actually this phone number input screen
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_verification/Button.dart';
import 'package:phone_number_verification/authprovider.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final TextEditingController phonecontroller = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India ",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<authprovider>(context, listen: true).isLoading;
    final ap = Provider.of<authprovider>(context, listen: true);
    phonecontroller.selection = TextSelection.fromPosition(TextPosition(
      offset: phonecontroller.text.length,
    ));
    return Scaffold(
      body: SafeArea(
        child: isLoading==true ?const Center(child: CircularProgressIndicator(color: Colors.black12,),): Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Column(children: [
              SizedBox(
                height: 23,
                width: 300,
              ),
              Text(
                "Please enter your mobile number",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 23,
                width: 171,
              ),
              Text(
                "You''ll receive a 6 digit code \n"
                "           to verify next.",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 25,
                width: 327,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                controller: phonecontroller,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    phonecontroller.text = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Mobile Number",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 550,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    suffixIcon: phonecontroller.text.length < 10
                        ? Container(
                            height: 30,
                            width: 30,
                          )
                        : null),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 328,
                height: 56,
                child: Button(
                    text: "CONTINUE", onPressed: () => sendphonenumber()),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void sendphonenumber() {
    final ap = Provider.of<authprovider>(context, listen: false);
    String phoneNumber = phonecontroller.text.trim();
    ap.signinwithphone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
