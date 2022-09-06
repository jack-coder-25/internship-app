import 'package:flutter/material.dart';
import 'package:mci/pages/profile/business_profile.dart';
import 'package:mci/pages/profile/member_profile.dart';
import 'package:provider/provider.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/models/user.dart';

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
