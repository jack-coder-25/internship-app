class ApiConstants {
  static const String baseUrl = 'https://bvcindia.in/utils';
  static const String uploadsPath = 'https://bvcindia.in/uploads';
  static const String memberProfile = '/user_app.php?auth_get=profile';
  static const String memberLogin = '/user_app.php?do=user_login';
  static const String memberRegistration = '/user_app.php?do=user_registration';

  static const String businessProfile = '/vendor_app.php?auth_get=profile';
  static const String businessLogin = '/vendor_app.php?do=user_login';
  static const String businessRegistration ='/vendor_app.php?do=user_registration';

  static const String sendOtp = '/user_app.php?do=send_phone_otp';
  static const String resendOtp = '/user_app.php?do=resend_phone_otp';
  static const String verifyOtp = '/user_app.php?do=verify_phone_otp';

  static const String memberSupport = '/user_app.php?auth_add=support_query';
  static const String businessSupport ='/vendor_app.php?auth_add=support_query';

  static const String memberResetPassword ='/user_app.php?do=user_reset_password';
  static const String businessResetPassword ='/vendor_app.php?do=user_reset_password';

  static const String requestOffer = '/vendor_app.php?auth_add=offer_requests';

  static const String memberNotifications ='/user_app.php?auth_get=app_notifications';
  static const String businessNotifications ='/vendor_app.php?auth_get=app_notifications';

  static const String memberSubscriptions ='/user_app.php?auth_get=subscription_plans';
  static const String businessSubscriptions ='/vendor_app.php?auth_get=subscription_plans';

  static const String memberProfileUpdate = '/user_app.php?auth_update=profile';
  static const String businessProfileUpdate ='/vendor_app.php?auth_update=profile';

  static const String memberTransactions = '/user_app.php?auth_get=wallet_txns';
  static const String businessTransactions = '/vendor_app.php?auth_get=txns';

  static const String memberSubscribe ='/user_app.php?auth_do=subscribe_to_plan';
  static const String businessSubscribe ='/vendor_app.php?auth_do=subscribe_to_plan';

  static const String memberTopup = '/user_app.php?auth_do=wallet_topup';
  static const String businessTopup = '/vendor_app.php?auth_do=wallet_topup';

  static const String bvcAdditionalCoupons ='/user_app.php?auth_get=bvc_coupon_list';
  static const String vendorCoupons ='/user_app.php?auth_get=vendor_coupon_list';

  static const String buyAdditionalCoupons ='/user_app.php?auth_get=buynow_additional_coupon';
  static const String buyVendorCoupons ='/user_app.php?auth_get=buynow_vendor_coupon';

  static const String ourBrands = '/user_app.php?get=our_brands';

  static const String memberDashboard = '/user_app.php?auth_get=summary_dashboard';
  static const String businessDashboard = '/vendor_app.php?auth_get=summary_dashboard';

  static const String memberSlides = '/user_app.php?auth_get=app_slides';
  static const String businessSlides = '/vendor_app.php?auth_get=app_slides';

  static const String searchVendors = '/user_app.php?auth_get=vendors';
  static const String getVendorDetails = '/user_app.php?auth_get=vendor_details';
  static const String getVendorServices = '/user_app.php?auth_get=vendor_services';

  static const String memberBookings = '/user_app.php?auth_get=my_bookings';
  static const String businessBookings = '/vendor_app.php?auth_get=bookings';
  static const String vendorServiceSlots = '/user_app.php?auth_get=vendor_service_slots';
  static const String serviceBooking = '/user_app.php?auth_do=service_booking';
}
