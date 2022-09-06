import 'package:flutter/material.dart';
import 'package:mci/pages/availability.dart';
import 'package:mci/pages/coupon_redemption.dart';
import 'package:mci/pages/coupons/coupons_wrapper.dart';
import 'package:mci/pages/package_subscription.dart';
import 'package:mci/pages/search_vendors.dart';
import 'package:mci/pages/spin_wheel.dart';
import 'package:mci/pages/wallet_topup.dart';
import 'package:provider/provider.dart';
import 'package:mci/pages/auth/member/member_signup.dart';
import 'package:mci/pages/clubs_and_association.dart';
import 'package:mci/pages/welcome.dart';
import 'package:mci/pages/auth/member/member_login.dart';
import 'package:mci/pages/auth/business/business_login.dart';
import 'package:mci/pages/auth/business/business_signup.dart';
import 'package:mci/pages/bar/bar_detail.dart';
import 'package:mci/pages/club_service_detail.dart';
import 'package:mci/pages/reset_password.dart';
import 'package:mci/pages/bar/bar_home.dart';
import 'package:mci/pages/additional_coupons.dart';
import 'package:mci/pages/profile/profile_wrapper.dart';
import 'package:mci/pages/club_detail.dart';
import 'package:mci/pages/offers/offers_wrapper.dart';
import 'package:mci/pages/bottom_bar.dart';
import 'package:mci/pages/partners.dart';
import 'package:mci/pages/subscription_detail.dart';
import 'package:mci/models/user.dart';
import 'package:mci/pages/splash_screen.dart';
import 'package:mci/pages/subscription.dart';
import 'package:mci/pages/referrals.dart';
import 'package:mci/pages/auth/otp_verify.dart';
import 'package:mci/pages/auth/authentication_wrapper.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/pages/onboarding/onboarding_wrapper.dart';
import 'package:mci/utils/authentication_service.dart';

late UserObject? userObject;

// ===TODO===
// Liqour Page (X)
// Comission for every transaction (X)
// Vendor Coupon Push (X)
// Create and Manage Services (X)
// Generate EaseBuzz access key on server (DB->Settings) (X)
// LuckyDraw
// Show & Apply coupon codes at club page
// Refferral code not working in 'subscribeToPlan'

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  userObject = await AuthenticationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        StreamProvider(
          create: (context) {
            return context.read<AuthenticationService>().authStateChanges;
          },
          initialData: userObject,
        )
      ],
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          primaryColor: ColorConstants.red,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ColorConstants.red,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/auth': (context) => const AuthenticationWrapper(),
          '/welcome': (context) => const WelcomePage(),
          '/member-login': (context) => MemberLoginPage(),
          '/member-signup': (context) => MemberSignupPage(),
          '/business-login': (context) => BusinessLoginPage(),
          '/business-signup': (context) => BusinessSignupPage(),
          '/otp-verify': (context) => const OtpVerifyPage(),
          '/reset-password': (context) => ResetPasswordPage(),
          '/search': (context) => const SearchPage(),
          '/bar-home': (context) => const BarHomePage(),
          '/bar-detail': (context) => const BarDetailPage(),
          '/onboarding': (context) => const OnboardingWrapper(),
          '/bottom-bar': (context) => const BottomBarPage(),
          '/profile': (context) => const ProfileWrapper(),
          '/referrals': (context) => const ReferralsPage(),
          '/offers': (context) => const OffersWrapper(),
          '/subscription': (context) => const SubscriptionPage(),
          '/coupons': (context) => const CouponsWrapper(),
          '/wallet-topup': (context) => const WalletTopupPage(),
          '/additional-coupons': (context) => const AdditionalCouponsPage(),
          '/partners': (context) => const PartnersPage(),
          '/spin-wheel': (context) => const SpinWheelPage(),
          '/subscription-detail': (context) => const SubscriptionDetailPage(),
          '/clubs-associations': (context) => const ClubsAndAssociationsPage(),
          '/club-detail': (context) => const ClubDetailPage(),
          '/club-service-detail': (context) => const ClubServicesDetailPage(),
          '/coupon-redemption': (context) => CouponRedemptionPage(),
          '/package-subscription': (context) => const PackageSubscriptionPage(),
          '/availability': (context) => const AvailabilityPage(),
        },
      ),
    );
  }
}
