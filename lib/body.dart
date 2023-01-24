import 'package:assignment_two/constants.dart';
import 'package:assignment_two/guest.dart';
import 'package:assignment_two/sms_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:masked_text/masked_text.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    super.initState();
    phoneFocus = FocusNode();
  }

  void dispose() {
    phoneFocus.dispose();
    super.dispose();
  }

  TextEditingController phoneN = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(gHeight / 13),
          child: Column(
            children: [
              buildPhoneNumberFormField(),
              SizedBox(height: gHeight / 15),
              buildLoginButton(),
              SizedBox(height: gHeight / 15),
              buildOr(),
              SizedBox(height: gHeight / 11),
              buildContinueWLButton(),
            ],
          ),
        ),
      ),
    );
  }

  MaskedTextField buildPhoneNumberFormField() {
    return MaskedTextField(
      onTap: _requestFocus,
      focusNode: phoneFocus,
      mask: "#### ### ####",
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: phoneN,
      showCursor: false,
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle:
            TextStyle(color: phoneFocus.hasFocus ? appBarColor : unocusedText),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: unocusedText)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: appBarColor)),
        prefix: Padding(
          padding: EdgeInsets.all(gHeight / 500),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (phoneN.text == phoneNumber) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SMSCode()));
        } else {}
      },
      child: Padding(
        padding: EdgeInsets.all(gHeight / 150),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login'),
            SizedBox(width: gWidth / 70),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Row buildOr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.0,
          width: gWidth / 4,
          color: Colors.grey.withOpacity(0.3),
        ),
        SizedBox(width: gWidth / 25),
        Text(
          "OR",
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(width: gWidth / 25),
        Container(
          height: 1.0,
          width: gWidth / 3.5,
          color: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }

  ElevatedButton buildContinueWLButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GuestPage()));
      },
      child: Padding(
        padding: EdgeInsets.all(gHeight / 150),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Continue without login',
              style: TextStyle(color: Color(0xff657B88)),
            ),
            SizedBox(width: gWidth / 70),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(phoneFocus);
    });
  }
}
