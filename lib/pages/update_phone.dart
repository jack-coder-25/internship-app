import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/validation.dart';
import 'package:app/pages/auth/otp_verify.dart';

class UpdatePhoneDialog extends StatefulWidget {
  const UpdatePhoneDialog({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneDialog> createState() => _UpdatePhoneDialogState();

  static void showUpdatePhoneDialog(BuildContext context) {
    _UpdatePhoneDialogState.showDialog(context);
  }
}

class _UpdatePhoneDialogState extends State<UpdatePhoneDialog> {
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();
  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late AuthenticationService authService;
  UserObject? user;

  @override
  void initState() {
    super.initState();
    authService = context.read<AuthenticationService>();
    getUserData();
  }

  void getUserData() async {
    final userObject = await authService.getUser();

    setState(() {
      user = userObject;
    });
  }

  void togglePasswordView() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.0,
      width: 400.0,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: validateMobile,
              controller: mobileTextController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixText: "+91",
                border: UnderlineInputBorder(),
                labelText: 'Mobile',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black87,
                    width: 2.0,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: validatePassword,
              controller: passwordTextController,
              obscureText: isPasswordHidden,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                  onPressed: togglePasswordView,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black87,
                    width: 2.0,
                  ),
                ),
                labelStyle: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BasicDialogAction(
                  title: const Text("OK"),
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      Navigator.pushNamed(
                        context,
                        '/otp-verify',
                        arguments: OtpVerifyPageArguments(
                          user: user!,
                          mobile: mobileTextController.text.trim(),
                          password: passwordTextController.text.trim(),
                          showOnboarding: false,
                        ),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static void showDialog(context) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text("Verify Your Phone Number"),
        content: const UpdatePhoneDialog(),
        actions: const [],
      ),
    );
  }
}
