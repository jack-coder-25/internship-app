import 'package:app/models/profile.dart';
import 'package:app/utils/authentication_service.dart';

class UserObject {
  UserObject({
    required this.email,
    required this.fullName,
    required this.dateOfBirth,
    required this.referralCode,
    required this.accountType,
    required this.authToken,
    required this.profile,
    required this.businessProfile,
  });

  final String email;
  final String fullName;
  final String dateOfBirth;
  final AccountType accountType;
  final String referralCode;
  final String authToken;
  final ProfileResponse? profile;
  final BusinessProfileResponse? businessProfile;
}
