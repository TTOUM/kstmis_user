import 'package:flutter/material.dart';

class Navigators {
  Navigators();

  navigatorPushAndRemove(BuildContext context ,Widget page) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page,), (route) => false);
  }
}
