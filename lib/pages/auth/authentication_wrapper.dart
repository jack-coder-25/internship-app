import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/welcome.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/bottom_bar.dart';
import 'package:app/pages/update_phone.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser != null) {
      if (firebaseUser.userCredential?.phoneNumber?.isEmpty == true) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          UpdatePhoneDialog.showUpdatePhoneDialog(context);
        });
      }

      return const BottomBarPage();
    }

    return const WelcomePage();
  }
}
