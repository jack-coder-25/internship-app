import 'package:mci/models/user.dart';
import 'package:mci/pages/coupons/business_coupons.dart';
import 'package:mci/pages/coupons/member_coupons.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponsWrapper extends StatelessWidget {
  const CouponsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser?.accountType == AccountType.member) {
      return const MemberCouponsPage();
    }

    return BusinessCouponsPage();
  }
}
