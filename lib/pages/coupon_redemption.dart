import 'package:flutter/material.dart';
import 'package:app/styles/buttton.dart';

class CouponRedemptionPage extends StatefulWidget {
  CouponRedemptionPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  State<CouponRedemptionPage> createState() => _CouponRedemptionPageState();
}

class _CouponRedemptionPageState extends State<CouponRedemptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupon Redemption "),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: BackButton(
          color: const Color.fromARGB(255, 251, 240, 240),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
              left: 16.0,
              right: 16.0,
              bottom: 700.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: widget._formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: ' Enter Coupon ',
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
                      ElevatedButton(
                        onPressed: (() => CouponRedemptionPage),
                        style: buttonStyleRed,
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(100.0)),
                      ElevatedButton(
                        onPressed: (() => CouponRedemptionPage),
                        style: buttonStyleRed,
                        child: const Text(
                          "View History",
                          style: TextStyle(
                            color: Color.fromARGB(255, 252, 4, 4),
                          ),
                        ),
                      ),
                    ],
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
