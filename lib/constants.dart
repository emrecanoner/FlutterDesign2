import 'package:flutter/material.dart';
import 'package:get/get.dart';

final gWidth = Get.width;
final gHeight = Get.height;
final appBarHeight = Get.height / 7.7;
//

final Color appBarColor = Color(0xff4CB050);
final Color welcomeColor = Color(0xff747474);
final Color unocusedText = Color(0xff9E9E9E);

AppBar appBar = AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: appBarColor,
  toolbarHeight: appBarHeight,
  centerTitle: true,
  title: Text("PERSONNEL INFORMATION SYSTEM"),
);

String phoneNumber = "0536 074 4701";
String SMSCodeNumber = "152256";

FocusNode phoneFocus = FocusNode();
FocusNode SMSFocus = FocusNode();
