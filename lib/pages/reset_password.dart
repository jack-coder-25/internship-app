import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/validation.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/helper.dart';
import 'package:app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ResetPasswordPageArguments {
  final AccountType accountType;

  ResetPasswordPageArguments({
    required this.accountType,
  });
}

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late AuthenticationService authService;
  late ResetPasswordPageArguments args;
  bool isPasswordHidden = true;
  int seconds = 30;
  String? otpKey;
  String _code = '';
  late Timer timer;

  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final otpTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var modalRoute = ModalRoute.of(context);
      args = modalRoute?.settings.arguments as ResetPasswordPageArguments;
      authService = context.read<AuthenticationService>();
    });
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

  void togglePasswordView() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  void onSubmit() async {
    if (widget.formKey.currentState?.validate() == true) {
      try {
        await authService.resetPassword(
          mobileTextController.text.trim(),
          passwordTextController.text.trim(),
          args.accountType,
        );

        await authService.signIn(
          username: mobileTextController.text.trim(),
          password: passwordTextController.text.trim(),
          accountType: args.accountType,
        );

        if (!mounted) return;
        Navigator.popUntil(context, ModalRoute.withName('/auth'));
      } catch (error) {
        showSnackbar(context, error.toString());
      }
    }
  }

  void onOtpSend() async {
    SmsAutoFill().listenForCode();

    if (validateMobile(mobileTextController.text) != null) {
      return;
    }

    if (otpKey == null) {
      // First Time
      startTime();

      var response = await authService.sendOtp(
        mobileTextController.text,
      );

      setState(() {
        otpKey = response.data?.otpKey;
      });
    } else {
      if (seconds == 0) {
        startTime();

        var response = await authService.reSendOtp(
          mobileTextController.text,
          otpKey!,
        );

        setState(() {
          otpKey = response.data?.otpKey;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: ColorConstants.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 16.0,
              right: 16.0,
              bottom: 0,
            ),
            child: Column(
              children: [
                Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateMobile,
                        keyboardType: TextInputType.phone,
                        controller: mobileTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Mobile',
                          prefixText: '+91',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFieldPinAutoFill(
                        currentCode: _code,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'OTP',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        onCodeChanged: (code) {
                          if (code.length == 4) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                          _code = code;
                        },
                        codeLength: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: otpKey == null
                                ? onOtpSend
                                : seconds == 0
                                    ? onOtpSend
                                    : null,
                            child: Text(
                              otpKey == null
                                  ? "Send OTP"
                                  : "Resend OTP in $seconds sec",
                              style: const TextStyle(
                                color: ColorConstants.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validatePassword,
                        controller: passwordTextController,
                        obscureText: isPasswordHidden,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black54),
                            onPressed: togglePasswordView,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Center(
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    style: buttonStyle,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
