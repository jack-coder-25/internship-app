import 'package:mci/models/user.dart';
import 'package:mci/pages/bookings/bookings_business.dart';
import 'package:mci/pages/bookings/bookings_member.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingsWrapper extends StatelessWidget {
  const BookingsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserObject?>();

    if (firebaseUser?.accountType == AccountType.member) {
      return const MemberBookingsPage();
    }

    return const BusinessBookingsPage();
  }
}
