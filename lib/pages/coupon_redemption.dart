import 'package:mci/constants/colors.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:mci/styles/buttton.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class CouponRedemptionPage extends StatefulWidget {
  CouponRedemptionPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  State<CouponRedemptionPage> createState() => _CouponRedemptionPageState();
}

class _CouponRedemptionPageState extends State<CouponRedemptionPage> {
  final couponCodeController = TextEditingController();

  Future<UserObject?> getUser() async {
    AuthenticationService authService = context.read<AuthenticationService>();
    return (await authService.getUser());
  }

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
                        controller: couponCodeController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Enter Coupon',
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
                        onPressed: () async {
                          if (couponCodeController.text.isEmpty) {
                            showSnackbar(context, 'Enter Coupon Code');
                            return;
                          }

                          var user = await getUser();
                          try {
                            await ApiService.instance.redeemVendorCoupon(
                              user!.authToken,
                              couponCodeController.text,
                            );
                            if (!mounted) return;
                            showSnackbar(
                              context,
                              'Coupon Redeemed Sucessfully',
                            );
                          } catch (error) {
                            if (!mounted) return;
                            showSnackbar(context, error.toString());
                          }
                        },
                        style: buttonStyle,
                        child: const Text(
                          "Apply",
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      ElevatedButton(
                        onPressed: () async {
                          var user = await getUser();

                          try {
                            var history =
                                await ApiService.instance.getRedeemedCoupons(
                              user!.authToken,
                            );

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: SizedBox(
                                  height: 450,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Redeemed Coupons',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 380,
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            itemCount: history.data!.length,
                                            itemBuilder: (((context, index) {
                                              return ListTile(
                                                title: Text(
                                                  history.data![index].code!,
                                                  style: const TextStyle(
                                                      color: ColorConstants.red,
                                                      fontSize: 18),
                                                ),
                                                subtitle: Html(
                                                  data: history.data![index]
                                                          .description ??
                                                      '',
                                                  style: {
                                                    'body': Style(
                                                      margin:
                                                          const EdgeInsets.all(
                                                        0,
                                                      ),
                                                    )
                                                  },
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                              );
                                            })),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } catch (error) {
                            if (!mounted) return;
                            showSnackbar(context, 'Cannot fetch history');
                          }
                        },
                        style: buttonStyle,
                        child: const Text(
                          "View History",
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
