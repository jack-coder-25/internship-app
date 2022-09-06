import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mci/pages/offers/member_offers.dart';
import 'package:mci/pages/offers/business_offers.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/models/user.dart';

class OffersWrapper extends StatelessWidget {
  const OffersWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser?.accountType == AccountType.member) {
      return const MemberOffersPage();
    }

    return BusinessOffersPage();
  }
}
