import 'package:flutter/material.dart';
import 'package:app/pages/profile/business_profile.dart';
import 'package:app/pages/profile/member_profile.dart';
import 'package:provider/provider.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/models/user.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser?.accountType == AccountType.member) {
      return MemberProfilePage();
    }

    return BusinessProfilePage();
  }
}
