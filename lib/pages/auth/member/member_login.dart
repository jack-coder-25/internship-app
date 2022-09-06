import 'package:mci/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/utils/validation.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/utils/helper.dart';

class MemberLoginPage extends StatefulWidget {
  MemberLoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<MemberLoginPage> createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  late AuthenticationService authService;
  bool isPasswordHidden = true;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authService = context.read<AuthenticationService>();
  }

  void togglePasswordView() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  void onLogin() async {
    if (widget.formKey.currentState?.validate() == true) {
      try {
        final user = await authService.signIn(
          username: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
          accountType: AccountType.member,
        );

        if (user?.accountType != AccountType.member) {
          throw Exception('Account type is not member');
        }

        if (!mounted) return;
        Navigator.popUntil(context, ModalRoute.withName('/auth'));
      } catch (error) {
        showSnackbar(context, error.toString());
      }
    }
  }

  void onForgotPassword() async {
    Navigator.pushNamed(
      context,
      '/reset-password',
      arguments: ResetPasswordPageArguments(
        accountType: AccountType.member,
      ),
    );
  }

  void onSignUpPress(BuildContext context) {
    Navigator.pushNamed(context, '/member-signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 48.0,
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/New-logo-red.png'),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                const Text(
                  "Welcome",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 26.0),
                ),
                const Text(
                  "Make your way to a new memorable moment",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
                Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateEmail,
                        controller: emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
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
                          focusColor: Colors.black,
                          labelText: 'Email',
                          hintText: 'mail@domain.com',
                        ),
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
                              color: Colors.black54,
                            ),
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
                const Padding(padding: EdgeInsets.all(4.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onForgotPassword,
                      style: TextButton.styleFrom(
                        primary: ColorConstants.red,
                      ),
                      child: const Text("Forgot Password"),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Center(
                  child: ElevatedButton(
                    onPressed: onLogin,
                    style: buttonStyle,
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "New Member ? ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextButton(
                      onPressed: () => onSignUpPress(context),
                      style: TextButton.styleFrom(
                        primary: ColorConstants.red,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
