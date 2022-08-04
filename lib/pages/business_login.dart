import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/validation.dart';
import 'package:app/utils/helper.dart';
import 'package:provider/provider.dart';

class BusinessLoginPage extends StatefulWidget {
  BusinessLoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<BusinessLoginPage> createState() => _BusinessLoginPageState();
}

class _BusinessLoginPageState extends State<BusinessLoginPage> {
  late AuthenticationService authService;
  bool isPasswordHidden = true;
  bool rememberChecked = false;

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

  void setRemember(bool? value) {
    setState(() {
      rememberChecked = value ?? false;
    });
  }

  void onLogin() async {
    if (widget.formKey.currentState?.validate() == true) {
      try {
        final user = await authService.signIn(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
        );

        if (user?.accountType != AccountType.business) {
          throw Exception('Account type is not business');
        }

        if (!mounted) return;
        Navigator.popUntil(context, ModalRoute.withName('/auth'));
      } catch (error) {
        String message = authService.handleFirebaseError(error);
        showSnackbar(context, message);
      }
    }
  }

  void onForgotPassword() async {
    if (emailTextController.text.isNotEmpty) {
      try {
        authService.sendPasswordResetEmail(emailTextController.text);
        if (!mounted) return;
        showSnackbar(context, 'Reset link sent to your email');
      } catch (error) {
        showSnackbar(context, error.toString());
      }
    } else {
      showSnackbar(context, 'Enter email to send reset link');
    }
  }

  void onSignUpPress(BuildContext context) {
    Navigator.pushNamed(context, '/business-signup');
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
                  child: Image.asset('assets/images/logo.png'),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Email',
                          hintText: 'mail@domain.com',
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
                const Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberChecked,
                          onChanged: (value) => setRemember(value),
                          activeColor: const Color.fromARGB(255, 255, 0, 0),
                        ),
                        const Text("Remember Me")
                      ],
                    ),
                    TextButton(
                      onPressed: onForgotPassword,
                      style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 0, 0),
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
                      "Don't have an account ? ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextButton(
                      onPressed: () => onSignUpPress(context),
                      style: TextButton.styleFrom(
                          primary: const Color.fromARGB(255, 255, 0, 0)),
                      child: const Text(
                        "Register",
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
