import 'package:app/pages/wallet_topup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/auth/member/member_signup.dart';
import 'package:app/pages/clubs_and_association.dart';
import 'package:app/pages/welcome.dart';
import 'package:app/pages/auth/member/member_login.dart';
import 'package:app/pages/auth/business/business_login.dart';
import 'package:app/pages/auth/business/business_signup.dart';
import 'package:app/pages/bar/bar_detail.dart';
import 'package:app/pages/club_services.dart';
import 'package:app/pages/reset_password.dart';
import 'package:app/pages/bar/bar_home.dart';
import 'package:app/pages/additional_coupons.dart';
import 'package:app/pages/profile/profile_wrapper.dart';
import 'package:app/pages/club_detail.dart';
import 'package:app/pages/offers/offers_wrapper.dart';
import 'package:app/pages/bottom_bar.dart';
import 'package:app/pages/coupons.dart';
import 'package:app/pages/partners.dart';
import 'package:app/pages/subscription_detail.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/dashboard.dart';
import 'package:app/pages/splash_screen.dart';
import 'package:app/pages/subscription.dart';
import 'package:app/pages/referrals.dart';
import 'package:app/pages/auth/otp_verify.dart';
import 'package:app/pages/auth/authentication_wrapper.dart';
import 'package:app/constants/colors.dart';
import 'package:app/pages/onboarding/onboarding_wrapper.dart';
import 'package:app/utils/authentication_service.dart';

late UserObject? userObject;

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
          '/bar-home': (context) => const BarHomePage(),
          '/bar-detail': (context) => const BarDetailPage(),
          '/onboarding': (context) => const OnboardingWrapper(),
          '/bottom-bar': (context) => const BottomBarPage(),
          '/dashboard': (context) => const DashboardPage(),
          '/profile': (context) => const ProfileWrapper(),
          '/referrals': (context) => const ReferralsPage(),
          '/offers': (context) => const OffersWrapper(),
          '/subscription': (context) => const SubscriptionPage(),
          '/coupons': (context) => const CouponsPage(),
          '/wallet-topup': (context) => const WalletTopupPage(),
          '/additional-coupons': (context) => const AdditionalCouponsPage(),
          '/partners': (context) => const PartnersPage(),
          '/subscription-detail': (context) => const SubscriptionDetailPage(),
          '/clubs-associations': (context) => const ClubsAndAssociationsPage(),
          '/club-detail': (context) => const ClubDetailPage(),
          '/club-service-detail': (context) => const ClubServicesDetailPage(),
        },
      ),
    );
  }
}
