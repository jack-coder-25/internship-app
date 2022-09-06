import 'package:flutter/material.dart';
import 'package:mci/constants/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  void _onMemberLogin(BuildContext context) {
    Navigator.pushNamed(context, '/member-login');
  }

  void _onBusinessLogin(BuildContext context) {
    Navigator.pushNamed(context, '/business-login');
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
                const Padding(
                  padding: EdgeInsets.all(25.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Align(alignment: Alignment.center),
                    // the login button
                    MaterialButton(
                      minWidth: 250.0,
                      height: 60,
                      onPressed: () => _onMemberLogin(context),
                      // defining the shape
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Member",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // creating the signup button
                    const SizedBox(height: 20),
                    MaterialButton(
                      minWidth: 250.0,
                      height: 60,
                      onPressed: () => _onBusinessLogin(context),
                      color: ColorConstants.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Business",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
