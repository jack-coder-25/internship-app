class ApiConstants {
  static const String baseUrl = 'https://bvcindia.in/utils';
  static const String memberProfile = '/user_app.php?auth_get=profile';
  static const String memberLogin = '/user_app.php?do=user_login';
  static const String memberRegistration = '/user_app.php?do=user_registration';

  static const String businessProfile = '/vendor_app.php?auth_get=profile';
  static const String businessLogin = '/vendor_app.php?do=user_login';
  static const String businessRegistration = '/vendor_app.php?do=user_registration';

  static const String sendOtp = '/user_app.php?do=send_phone_otp';
  static const String resendOtp = '/user_app.php?do=resend_phone_otp';
  static const String verifyOtp = '/user_app.php?do=verify_phone_otp';

  static const String memberSupport = '/user_app.php?auth_add=support_query';
  static const String businessSupport = '/vendor_app.php?auth_add=support_query';

  static const String memberResetPassword = '/user_app.php?do=user_reset_password';
  static const String businessResetPassword = '/vendor_app.php?do=user_reset_password';

  static const String requestOffer = '/vendor_app.php?auth_add=offer_requests';

  static const String memberNotifications = '/user_app.php?auth_get=app_notifications';
  static const String businessNotifications = '/vendor_app.php?auth_get=app_notifications';

  static const String memberSubscriptions = '/user_app.php?auth_get=subscription_plans';
  static const String businessSubscriptions = '/vendor_app.php?auth_get=subscription_plans';

  static const String memberProfileUpdate = '/user_app.php?auth_update=profile';
  static const String businessProfileUpdate = '/vendor_app.php?auth_update=profile';

  static const String memberTransactions = '/user_app.php?auth_get=wallet_txns';
  static const String businessTransactions = '/vendor_app.php?auth_get=txns';

  static const String memberSubscribe = '/user_app.php?auth_do=subscribe_to_plan';
  static const String businessSubscribe = '/vendor_app.php?auth_do=subscribe_to_plan';

  static const String memberTopup = '/user_app.php?auth_do=wallet_topup';
  static const String businessTopup = '/vendor_app.php?auth_do=wallet_topup';
}
