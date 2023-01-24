import 'dart:async';
import 'dart:ui';

import 'package:assignment_two/constants.dart';
import 'package:assignment_two/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SMSCode extends StatefulWidget {
  const SMSCode({super.key});

  @override
  State<SMSCode> createState() => _SMSCodeState();
}

class _SMSCodeState extends State<SMSCode> {
  bool numLength = false;
  int secondsRemaining = 20;
  bool enableResend = false;
  Timer? timer;
  final formKey = GlobalKey<FormState>();
  TextEditingController SMSCodeController = TextEditingController();

  void initState() {
    super.initState();
    SMSFocus = FocusNode();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
          SMSCodeController.text = "";
        });
      }
    });
  }

  void dispose() {
    Focus.of(context).unfocus();
    SMSFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(gHeight / 9),
            child: Column(
              children: [
                SizedBox(height: gHeight / 40),
                Center(
                  child: Text(
                    "Please enter the verification code sent to your mobile phone number with ${phoneNumber}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: gHeight / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: enableResend ? Colors.red : Colors.black,
                    ),
                    SizedBox(
                      width: gWidth / 150,
                    ),
                    Text(
                      "$secondsRemaining",
                      style: TextStyle(
                          color: enableResend ? Colors.red : Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: gHeight / 20),
                buildSMSCodeFormField(),
                SizedBox(height: gHeight / 10),
                buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildContinueButton() {
    return ElevatedButton(
      onPressed:
          enableResend ? resendCompare : (numLength ? buttonCompare : null),
      child: Padding(
        padding: EdgeInsets.all(gHeight / 150),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              enableResend ? 'Resend' : 'Continue',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: enableResend
            ? MaterialStateProperty.all(Colors.black)
            : (numLength
                ? MaterialStateProperty.all(Colors.black)
                : MaterialStateProperty.all(Colors.grey)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  TextFormField buildSMSCodeFormField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          if (value.length < 6) {
            setState(() {
              numLength = false;
            });
          } else {
            setState(() {
              numLength = true;
            });
          }
        });
      },
      key: formKey,
      onTap: _requestFocus,
      focusNode: SMSFocus,
      maxLength: 6,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: SMSCodeController,
      showCursor: false,
      decoration: InputDecoration(
        labelText: "SMS Code",
        labelStyle: TextStyle(
            color: SMSFocus.hasFocus
                ? (numLength ? appBarColor : Colors.red)
                : unocusedText),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: unocusedText)),
        focusedBorder: numLength
            ? OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: appBarColor))
            : OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.red)),
        prefix: Padding(
          padding: EdgeInsets.all(gHeight / 500),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScopeNode currentFocus = FocusScope.of(context);
    });
  }

  void buttonCompare() {
    if (SMSCodeController.text == SMSCodeNumber) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (MemberPage())));
    } else {}
  }

  void resendCompare() {
    SMSCodeController.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (SMSCode())));
  }
}
