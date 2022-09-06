import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mci/pages/welcome.dart';
import 'package:mci/models/user.dart';
import 'package:mci/pages/bottom_bar.dart';

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
