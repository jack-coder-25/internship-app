import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mci/models/user.dart';
import 'package:mci/pages/auth/otp_verify.dart';
import 'package:mci/utils/validation.dart';
import 'package:mci/utils/helper.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/styles/buttton.dart';

class BusinessSignupPage extends StatefulWidget {
  BusinessSignupPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<BusinessSignupPage> createState() => _BusinessSignupPageState();
}

class _BusinessSignupPageState extends State<BusinessSignupPage> {
  late AuthenticationService authService;
  bool isPasswordHidden = true;
  String? dropDownError;
  final fullNameTextController = TextEditingController();
  final dateOfBirthTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final referralCodeTextController = TextEditingController();
  String? currentSelectedValue;

  final _categories = [
    "Hotel",
    "Club",
    "Resort",
    "Saloon",
    "Parlour",
    "Service Apartments",
    "Textile",
    "Jewellery Shop",
    "SPA",
    "Marriage Hall",
    "Provision Bazzar",
    "Restaurant",
    "Cinema Online Tickets",
    "Online Discount Shopping",
    "Tours & Travels",
    "Gym",
    "Online Recharge",
    "Others",
    "Hotels and Resorts",
    "Electronices",
    "Mobile Phones",
    "Launday Services",
    "Medicines",
    "Beach Resort"
  ];

  @override
  void initState() {
    super.initState();
    authService = context.read<AuthenticationService>();
  }

  void onSignup(BuildContext context) async {
    setState(() {
      if (currentSelectedValue == null) {
        dropDownError = 'Select a category';
      } else {
        dropDownError = null;
      }
    });

    if (dropDownError != null) {
      return;
    }

    if (widget.formKey.currentState?.validate() == true) {
      UserObject? user;

      try {
        user = await authService.signUp(
          email: emailTextController.text.trim(),
          phone: mobileTextController.text.trim(),
          password: passwordTextController.text.trim(),
          name: fullNameTextController.text.trim(),
          dateOfBirth: dateOfBirthTextController.text.trim(),
          referralCode: referralCodeTextController.text.trim(),
          accountType: AccountType.business,
          category: currentSelectedValue!,
        );
      } catch (error) {
        showSnackbar(context, error.toString());
      }

      if (!mounted || user == null) return;

      Navigator.pushNamed(
        context,
        '/otp-verify',
        arguments: OtpVerifyPageArguments(
          user: user,
          mobile: mobileTextController.text.trim(),
          password: passwordTextController.text.trim(),
          showOnboarding: true,
          accountType: AccountType.business,
        ),
      );
    }
  }

  void togglePasswordView() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  void setDateInput(DateTime dateTime) {
    setState(() {
      dateOfBirthTextController.text =
          DateFormat('dd-MM-yyyy').format(dateTime);
    });
  }

  void onLoginPress(BuildContext context) {
    Navigator.pop(context);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26.0),
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
                Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              errorText: dropDownError,
                              hintText: 'Select Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            isEmpty: currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentSelectedValue,
                                hint: const Text('Select Category'),
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                isExpanded: true,
                                menuMaxHeight: 400.0,
                                alignment: AlignmentDirectional.centerStart,
                                items: _categories.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validateFullName,
                        controller: fullNameTextController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Full Name',
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
                        validator: validateDateOfBirth,
                        controller: dateOfBirthTextController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                          labelText: "Date Of Birth",
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
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorConstants.red,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            setDateInput(pickedDate);
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        controller: mobileTextController,
                        validator: validateMobile,
                        decoration: InputDecoration(
                          prefixText: "+91",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Mobile',
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
                        controller: emailTextController,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
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
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: (value) => validateConfirmPassword(
                          value,
                          passwordTextController.text,
                        ),
                        controller: confirmPasswordTextController,
                        obscureText: isPasswordHidden,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Confirm Password',
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
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        controller: referralCodeTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Referral Code',
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
                    onPressed: () => onSignup(context),
                    style: buttonStyle,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Member ? ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextButton(
                      onPressed: () => onLoginPress(context),
                      style: TextButton.styleFrom(
                        primary: ColorConstants.red,
                      ),
                      child: const Text(
                        "Login",
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

  @override
  void dispose() {
    fullNameTextController.dispose();
    emailTextController.dispose();
    mobileTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    dateOfBirthTextController.dispose();
    referralCodeTextController.dispose();
    super.dispose();
  }
}
