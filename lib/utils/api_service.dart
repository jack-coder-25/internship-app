import 'dart:io';

import 'package:app/models/notifications.dart';
import 'package:app/models/offers.dart';
import 'package:app/models/profile.dart';
import 'package:app/models/subscriptions.dart';
import 'package:app/models/support.dart';
import 'package:app/models/user.dart';
import 'package:app/models/wallet.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:dio/dio.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/auth.dart';

class ApiService {
  static ApiService? _instance;
  ApiService._();
  static ApiService get instance => _instance ??= ApiService._();

  Future<UserObject> getMemberProfile(
    String authToken,
  ) async {
    try {
      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.memberProfile,
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      if (response.statusCode == 200) {
        final profile = ProfileResponse.fromJson(response.data);

        return UserObject(
            email: profile.data!.email!,
            fullName: profile.data?.name ?? '',
            dateOfBirth: profile.data?.dob ?? '',
            referralCode: profile.data?.referralCode ?? '',
            accountType: AccountType.member,
            authToken: authToken,
            profile: profile,
            businessProfile: null);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponse> memberLogin(
    String username,
    String password,
  ) async {
    try {
      var formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.memberLogin,
        data: formData,
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);

        if (loginResponse.status == 'failed') {
          throw Exception(loginResponse.message);
        }

        return loginResponse;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RegistrationResponse> memberRegistration(
    String name,
    String email,
    String phone,
    String password,
    String dob,
    String referralCode,
  ) async {
    try {
      var formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'dob': dob,
        'referral_code': referralCode,
      });

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.memberRegistration,
        data: formData,
      );

      if (response.statusCode == 200) {
        final registrationResponse = RegistrationResponse.fromJson(
          response.data,
        );

        if (registrationResponse.status == 'failed') {
          throw Exception(registrationResponse.message);
        }

        return registrationResponse;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserObject> getBusinessProfile(
    String authToken,
  ) async {
    try {
      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.businessProfile,
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      if (response.statusCode == 200) {
        final businessProfile = BusinessProfileResponse.fromJson(response.data);

        return UserObject(
            email: businessProfile.data!.email!,
            fullName: businessProfile.data?.name ?? '',
            dateOfBirth: businessProfile.data?.dob ?? '',
            referralCode: businessProfile.data?.referralCode ?? '',
            accountType: AccountType.business,
            authToken: authToken,
            businessProfile: businessProfile,
            profile: null);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponse> businessLogin(
    String username,
    String password,
  ) async {
    try {
      var formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.businessLogin,
        data: formData,
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);

        if (loginResponse.status == 'failed') {
          throw Exception(loginResponse.message);
        }

        return loginResponse;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RegistrationResponse> businessRegistration(
    String name,
    String email,
    String phone,
    String password,
    String dob,
    String type,
    String referralCode,
  ) async {
    try {
      var formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'dob': dob,
        'type': type,
        'referral_code': referralCode,
      });

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.businessRegistration,
        data: formData,
      );

      if (response.statusCode == 200) {
        return RegistrationResponse.fromJson(
          response.data,
        );
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<OtpResponse> sendOtp(String phone) async {
    try {
      var formData = FormData.fromMap({'phone': phone});

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.sendOtp,
        data: formData,
      );

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<OtpResponse> resendOtp(String phone, String otpKey) async {
    try {
      var formData = FormData.fromMap({'phone': phone, 'otp_key': otpKey});

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.resendOtp,
        data: formData,
      );

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<OtpResponse> verifyOtp(
    String otp,
    String otpKey,
  ) async {
    try {
      var formData = FormData.fromMap({'otp': otp, 'otp_key': otpKey});

      var response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.verifyOtp,
        data: formData,
      );

      if (response.statusCode == 200) {
        return OtpResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SupportResponse> sendSupportQuery(
    String name,
    String phone,
    String email,
    String message,
    AccountType accountType,
  ) async {
    try {
      var formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'email': email,
        'message': message,
      });

      Response<dynamic> response;

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberSupport,
          data: formData,
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessProfile,
          data: formData,
        );
      }

      if (response.statusCode == 200) {
        return SupportResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PasswordResetResponse> memberResetPassword(
    String username,
    String password,
    AccountType accountType,
  ) async {
    try {
      var formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      Response<dynamic> response;

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberResetPassword,
          data: formData,
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessResetPassword,
          data: formData,
        );
      }

      if (response.statusCode == 200) {
        return PasswordResetResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<OfferUploadResponse> requestOffer(
    String title,
    String description,
    File file,
    String authToken,
  ) async {
    try {
      var formData = FormData.fromMap({
        'title': title,
        'description': description,
        'image': await MultipartFile.fromFile(file.path),
      });

      Response<dynamic> response = await Dio().post(
        ApiConstants.baseUrl + ApiConstants.requestOffer,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      if (response.statusCode == 200) {
        var data = OfferUploadResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<NotificationResponse> getUserNotifications(
    String authToken,
    AccountType accountType,
  ) async {
    try {
      Response<dynamic> response;

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberNotifications,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessNotifications,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = NotificationResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SubscriptionsResponse> getSubscriptions(
    String authToken,
    AccountType accountType,
  ) async {
    try {
      Response<dynamic> response;

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberSubscriptions,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessSubscriptions,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = SubscriptionsResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProfileUpdateResponse> updateProfile({
    required String authToken,
    required AccountType accountType,
    String? name,
    String? fatherName,
    String? motherName,
    String? occupation,
    String? married,
    String? weddingDate,
    String? spouseDob,
    String? spouseName,
    String? numberOfChild,
    String? doorNumber,
    String? buildingName,
    String? city,
    String? state,
    String? password,
    String? confirmPassword,
    String? mobile,
    String? alterMobile,
    String? email,
    String? dob,
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
    try {
      Response<dynamic> response;

      var aadharNew =
          aadhar != null ? await MultipartFile.fromFile(aadhar.path) : null;

      var panNew = pan != null ? await MultipartFile.fromFile(pan.path) : null;

      var photoNew =
          photo != null ? await MultipartFile.fromFile(photo.path) : null;

      var formData = FormData.fromMap({
        'name': name,
        'father_name': fatherName,
        'mother_name': motherName,
        'occupation': occupation,
        'marital_status': married,
        'wedding_date': weddingDate,
        'spouse_dob': spouseDob,
        'spouse_name': spouseName,
        'childrens': numberOfChild,
        'door_no': doorNumber,
        'building_name': buildingName,
        'city': city,
        'state': state,
        'email': email,
        'phone': mobile,
        'address': address,
        'alter_phone': alterMobile,
        'contact_person': contactPerson,
        'auth_sign': authSignature,
        'password': password,
        'lat': latLon,
        'dob': dob,
        'gst': gstNumber,
        'gst_exept': gstExempt,
        'bank_account_name': bankAccountName,
        'bank_account_number': bankAccountNumber,
        'bank_account_type': bankAccountType,
        'aadhar': aadharNew,
        'pan': panNew,
        'photo': photoNew,
      });

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberProfileUpdate,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessProfileUpdate,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = ProfileUpdateResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WalletTransactionsResponse> getUserTransactions(
    String authToken,
    AccountType accountType,
  ) async {
    try {
      Response<dynamic> response;

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberTransactions,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessTransactions,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = WalletTransactionsResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SubscribeResponse> subscribeToPlan(
    String authToken,
    AccountType accountType,
    String planId,
    String? referralCode,
  ) async {
    try {
      Response<dynamic> response;

      var formData = FormData.fromMap({
        'plan_id': planId,
        // TODO: Referall code not working
        // 'referral_code': referralCode,
      });

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberSubscribe,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessSubscribe,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = SubscribeResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WalletTopupResponse> topupWallet(
    String authToken,
    AccountType accountType,
    String transcationId,
    String amount,
  ) async {
    try {
      Response<dynamic> response;

      var formData = FormData.fromMap({
        'txn_id': transcationId,
        'amount': amount,
      });

      if (accountType == AccountType.member) {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.memberTopup,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      } else {
        response = await Dio().post(
          ApiConstants.baseUrl + ApiConstants.businessTopup,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $authToken'},
          ),
        );
      }

      if (response.statusCode == 200) {
        var data = WalletTopupResponse.fromJson(response.data);

        if (data.status == 'failed') {
          throw Exception(data.message);
        }

        return data;
      } else {
        throw Exception('Something went wrong [${response.statusCode}]');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}