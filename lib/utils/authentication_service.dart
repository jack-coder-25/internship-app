import 'dart:async';
import 'dart:io';
import 'package:app/models/auth.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AccountType { member, business }

const String token = 'token';

AccountType stringToAccountType(String accountType) {
  switch (accountType) {
    case 'member':
      return AccountType.member;
    case 'business':
      return AccountType.business;
    default:
      throw Exception('Invalid accountType cannot convert "$accountType"');
  }
}

final controller = StreamController<UserObject?>.broadcast();

class AuthenticationService {
  static const storage = FlutterSecureStorage();
  AuthenticationService();
  static UserObject? userObject;
  Stream<UserObject?> get authStateChanges => controller.stream;

  static Future<UserObject?> _fetchUser() async {
    final authToken = await storage.read(key: token) ?? '';

    if (authToken == '') {
      controller.sink.add(null);
      return null;
    }

    try {
      try {
        userObject = await ApiService.instance.getMemberProfile(
          authToken,
        );

        controller.sink.add(userObject);
        return userObject;
      } catch (error) {
        // Do Nothing
      }

      try {
        userObject = await ApiService.instance.getBusinessProfile(
          authToken,
        );

        controller.sink.add(userObject);
        return userObject;
      } catch (error) {
        // Do Nothing
      }
    } on Exception {
      return null;
    }

    controller.sink.add(userObject);
    return null;
  }

  static Future<UserObject?> init() async {
    return await _fetchUser();
  }

  Future<bool> isUserLoggedIn() async {
    return await storage.read(key: token) != null;
  }

  Future<UserObject?> signIn({
    required String username,
    required String password,
    required AccountType accountType,
  }) async {
    try {
      LoginResponse loginResponse;
      UserObject userObject;

      switch (accountType) {
        case AccountType.member:
          loginResponse = await ApiService.instance.memberLogin(
            username,
            password,
          );

          userObject = await ApiService.instance.getMemberProfile(
            loginResponse.data!.authToken!,
          );

          await storage.write(
            key: token,
            value: loginResponse.data?.authToken,
          );
          controller.sink.add(userObject);
          return userObject;
        case AccountType.business:
          loginResponse = await ApiService.instance.businessLogin(
            username,
            password,
          );

          userObject = await ApiService.instance.getBusinessProfile(
            loginResponse.data!.authToken!,
          );

          await storage.write(
            key: token,
            value: loginResponse.data?.authToken,
          );
          controller.sink.add(userObject);
          return userObject;
        default:
      }
    } on Exception {
      rethrow;
    }

    return null;
  }

  Future<UserObject?> signUp({
    required String email,
    required String phone,
    required String password,
    required String name,
    required String dateOfBirth,
    required String referralCode,
    required AccountType accountType,
    required String category,
  }) async {
    RegistrationResponse registrationResponse;
    UserObject userObject;

    try {
      switch (accountType) {
        case AccountType.member:
          registrationResponse = await ApiService.instance.memberRegistration(
            name,
            email,
            phone,
            password,
            dateOfBirth,
            referralCode,
          );

          userObject = await ApiService.instance.getMemberProfile(
            registrationResponse.data!.authToken!,
          );

          await storage.write(
            key: token,
            value: registrationResponse.data?.authToken,
          );
          controller.sink.add(userObject);
          return userObject;
        case AccountType.business:
          registrationResponse = await ApiService.instance.businessRegistration(
            name,
            email,
            phone,
            password,
            dateOfBirth,
            category,
            referralCode,
          );

          userObject = await ApiService.instance.getBusinessProfile(
            registrationResponse.data!.authToken!,
          );

          await storage.write(
            key: token,
            value: registrationResponse.data?.authToken,
          );
          controller.sink.add(userObject);
          return userObject;
        default:
      }
    } on Exception {
      rethrow;
    }

    return null;
  }

  Future<void> signOut() async {
    try {
      await storage.delete(key: token);
      userObject = null;
      controller.sink.add(null);
    } on Exception {
      rethrow;
    }
  }

  Future<UserObject?> getUser() async {
    if (userObject != null) {
      _fetchUser();
      return userObject;
    }

    return await _fetchUser();
  }

  Future<ProfileUpdateResponse> updateProfile({
    String? name,
    String? fatherName,
    String? motherName,
    String? occupation,
    String? password,
    String? confirmPassword,
    String? mobile,
    String? alterMobile,
    String? email,
    String? married,
    String? dob,
    String? weddingDate,
    String? spouseName,
    String? spouseDob,
    String? numberOfChild,
    String? doorNumber,
    String? buildingName,
    String? city,
    String? state,
    String? brandName,
    String? landline,
    String? authSignature,
    String? contactPerson,
    String? address,
    String? webLink,
    String? bankAccountName,
    String? bankAccountNumber,
    String? bankAccountType,
    String? bankIfscCode,
    String? gstNumber,
    String? gstExempt,
    String? latLon,
    File? aadhar,
    File? pan,
    File? photo,
  }) async {
    var response = await ApiService.instance.updateProfile(
      authToken: userObject!.authToken,
      accountType: userObject!.accountType,
      name: name,
      fatherName: fatherName,
      motherName: motherName,
      occupation: occupation,
      password: password,
      confirmPassword: confirmPassword,
      mobile: mobile,
      alterMobile: alterMobile,
      email: email,
      married: married,
      dob: dob,
      weddingDate: weddingDate,
      spouseName: spouseName,
      spouseDob: spouseDob,
      numberOfChild: numberOfChild,
      doorNumber: doorNumber,
      buildingName: buildingName,
      city: city,
      state: state,
      brandName: brandName,
      landline: landline,
      authSignature: authSignature,
      contactPerson: contactPerson,
      address: address,
      webLink: webLink,
      bankAccountName: bankAccountName,
      bankAccountNumber: bankAccountNumber,
      bankAccountType: bankAccountType,
      bankIfscCode: bankIfscCode,
      gstNumber: gstNumber,
      gstExempt: gstExempt,
      latLon: latLon,
      aadhar: aadhar,
      pan: pan,
      photo: photo,
    );

    await getUser();
    return response;
  }

  Future<PasswordResetResponse> resetPassword(
    String username,
    String password,
    AccountType accountType,
  ) async {
    return await ApiService.instance.memberResetPassword(
      username,
      password,
      accountType,
    );
  }

  Future<OtpResponse> sendOtp(String phone) async {
    return await ApiService.instance.sendOtp(phone);
  }

  Future<OtpResponse> reSendOtp(String phone, String otpKey) async {
    return await ApiService.instance.resendOtp(phone, otpKey);
  }

  Future<OtpResponse> verifyOtp(String otp, String otpKey) async {
    return await ApiService.instance.verifyOtp(otp, otpKey);
  }
}
