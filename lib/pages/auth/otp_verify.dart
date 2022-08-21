import 'dart:async';
import 'package:app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/helper.dart';
import 'package:app/constants/colors.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerifyPageArguments {
  final UserObject user;
  final String mobile;
  final String password;
  final bool showOnboarding;
  final AccountType accountType;

  OtpVerifyPageArguments({
    required this.user,
    required this.mobile,
    required this.password,
    required this.showOnboarding,
    required this.accountType,
  });
}

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({Key? key}) : super(key: key);

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  late AuthenticationService authService;
  late OtpVerifyPageArguments args;
  int seconds = 30;
  String countryCode = '+91';
  final pinController = TextEditingController();
  String otpKey = '';
  String _code = '';
  late Timer timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var modalRoute = ModalRoute.of(context);
      args = modalRoute?.settings.arguments as OtpVerifyPageArguments;
      authService = context.read<AuthenticationService>();
      startTime();
      verifyPhoneNumber();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void startTime() async {
    var duration = const Duration(seconds: 1);
    seconds = 30;

    timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (seconds > 0) {
          seconds = seconds - 1;
        }
      });
    });
  }

  void resendOtp() async {
    startTime();
    final otpResponse = await authService.reSendOtp(args.mobile, otpKey);
    otpKey = otpResponse.data?.otpKey ?? '';
  }

  void verifyPhoneNumber() async {
    try {
      SmsAutoFill().listenForCode();
      final otpResponse = await authService.sendOtp(args.mobile);
      otpKey = otpResponse.data?.otpKey ?? '';
    } catch (error) {
      if (!mounted) return;
      showSnackbar(context, error.toString());
    }
  }

  void onSubmit() async {
    try {
      await authService.verifyOtp(_code, otpKey);

      authService.signIn(
        username: args.user.email,
        password: args.password,
        accountType: args.accountType,
      );

      if (!mounted) return;

      if (args.showOnboarding) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/onboarding",
          (r) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/auth",
          (r) => false,
        );
      }
    } catch (error) {
      showSnackbar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.red,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 48.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Verify OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: const Text(
                          "We have sent an OTP to your mobile number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    const Text(
                      "Enter 4 Digit PIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: PinFieldAutoFill(
                          currentCode: _code,
                          decoration: const UnderlineDecoration(
                            colorBuilder: FixedColorBuilder(Colors.white),
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          onCodeChanged: (code) {
                            if (code!.length == 4) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                            _code = code;
                          },
                          codeLength: 4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: seconds == 0 ? resendOtp : null,
                      child: Text(
                        seconds == 0 ? "Resend OTP" : "Resend in $seconds sec",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: buttonStyleRed,
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: ColorConstants.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
