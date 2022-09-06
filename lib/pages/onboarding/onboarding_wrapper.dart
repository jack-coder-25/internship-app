import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mci/models/user.dart';
import 'package:mci/pages/onboarding/onboarding_business.dart';
import 'package:mci/pages/onboarding/onboarding_member.dart';
import 'package:mci/utils/authentication_service.dart';

class OnboardingWrapper extends StatelessWidget {
  const OnboardingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser?.accountType == AccountType.member) {
      return const OnBoardingMember();
    }

    return const OnBoardingBusiness();
  }
}
