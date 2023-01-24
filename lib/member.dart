import 'package:assignment_two/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.only(bottom: gHeight / 5),
        child: Center(
          child: Text("Welcome\nÖzgür Özşen!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: welcomeColor,
                fontSize: 50,
              )),
        ),
      ),
    );
  }
}
