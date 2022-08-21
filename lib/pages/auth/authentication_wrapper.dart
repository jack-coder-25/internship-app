import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/welcome.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/bottom_bar.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser != null) {
      return const BottomBarPage();
    }

    return const WelcomePage();
  }
}
