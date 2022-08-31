import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/coupons.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

class AdditionalCouponsPage extends StatefulWidget {
  const AdditionalCouponsPage({Key? key}) : super(key: key);

  @override
  State<AdditionalCouponsPage> createState() => _AdditionalCouponsPageState();
}

class _AdditionalCouponsPageState extends State<AdditionalCouponsPage> {
  UserObject? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = context.read<UserObject?>();
      setState(() {});

      if (user?.profile?.data?.subscription == null) {
        Navigator.pushReplacementNamed(context, '/subscription');
      }
    });
  }

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Other Coupons'),
    const Tab(text: 'Vendor Coupons'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Additional Coupons'),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            OtherCouponsGrid(),
            VendorCouponsGrid(),
          ],
        ),
      ),
    );
  }
}

void showConfirmationAlert(
  BuildContext context,
  bool mounted,
  Data coupon,
  UserObject? user,
  String type,
) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text(
        coupon.title!,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 420.0,
        width: 380.0,
        child: Column(
          children: [
            Image.network(
              height: 140.0,
              '${ApiConstants.uploadsPath}/${coupon.image!}',
              fit: BoxFit.cover,
              loadingBuilder: ((
                context,
                child,
                loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return Container(color: Colors.grey);
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vendor"),
                Text(coupon.name!),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Service"),
                Text(coupon.categoryName!),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Coupon Validity Period",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("From Date"),
                Text(coupon.startsOn!),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("To Date"),
                Text(coupon.endsOn!),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Coupon"),
                Text(coupon.code!),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Coupon Amount"),
                Text(
                  "₹${coupon.amount!}",
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Buy Amount"),
                Text(
                  "₹${coupon.additionalAmount!}",
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: ColorConstants.red,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                if (type == 'vendor') {
                  await ApiService.instance.buyVendorCoupons(
                    user!.authToken,
                    coupon.id!,
                  );
                } else {
                  await ApiService.instance.buyAdditionalCoupons(
                    user!.authToken,
                    coupon.id!,
                  );
                }

                if (!mounted) return;
                Navigator.pop(context);
                showSnackbar(context, 'Coupon Bought Sucessfully');
              } catch (error) {
                showSnackbar(context, error.toString());
              }
            },
            style: ElevatedButton.styleFrom(
              primary: ColorConstants.red,
            ),
            child: const Text("Buy"),
          ),
        ),
      ],
    ),
  );
}

Widget loadingSpinner() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      CircularProgressIndicator(
        color: ColorConstants.red,
      ),
    ],
  );
}

Widget errorScreen(String? error) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(error ?? "Something went wrong"),
    ],
  );
}

class OtherCouponsGrid extends StatefulWidget {
  const OtherCouponsGrid({Key? key}) : super(key: key);

  @override
  State<OtherCouponsGrid> createState() => _OtherCouponsGridState();
}

class _OtherCouponsGridState extends State<OtherCouponsGrid> {
  @override
  Widget build(BuildContext context) {
    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    return Container(
      color: Colors.white30,
      child: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<AdditionalCouponResponse>(
              future: ApiService.instance.getBvcAdditionalCoupons(
                userSnapshot.data!.authToken,
                userSnapshot.data!.profile!.data!.subscriptionId!,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .82,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 4.0,
                    children: snapshot.data!.data!.map((Data coupon) {
                      return GridTile(
                        child: Column(
                          children: [
                            Image.network(
                              height: 140.0,
                              '${ApiConstants.uploadsPath}/${coupon.image!}',
                              fit: BoxFit.cover,
                              loadingBuilder: ((
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Container(color: Colors.grey);
                              }),
                            ),
                            const SizedBox(height: 5),
                            Text(coupon.title!),
                            Text(coupon.name!),
                            Text(coupon.categoryName!),
                            ElevatedButton(
                              onPressed: () {
                                showConfirmationAlert(
                                  context,
                                  mounted,
                                  coupon,
                                  userSnapshot.data,
                                  'additional',
                                );
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                coupon.code!,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  children = errorScreen(snapshot.error.toString());
                } else {
                  children = loadingSpinner();
                }

                return Center(child: children);
              }),
            );
          } else if (userSnapshot.hasError) {
            return errorScreen(userSnapshot.error.toString());
          } else {
            return loadingSpinner();
          }
        }),
      ),
    );
  }
}

class VendorCouponsGrid extends StatefulWidget {
  const VendorCouponsGrid({Key? key}) : super(key: key);

  @override
  State<VendorCouponsGrid> createState() => _VendorCouponsGridState();
}

class _VendorCouponsGridState extends State<VendorCouponsGrid> {
  @override
  Widget build(BuildContext context) {
    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    return Container(
      color: Colors.white30,
      child: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<AdditionalCouponResponse>(
              future: ApiService.instance.getVendorAdditionalCoupons(
                userSnapshot.data!.authToken,
                userSnapshot.data!.profile!.data!.subscriptionId!,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .82,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 4.0,
                    children: snapshot.data!.data!.map((Data coupon) {
                      return GridTile(
                        child: Column(
                          children: [
                            Image.network(
                              height: 140.0,
                              '${ApiConstants.uploadsPath}/${coupon.image!}',
                              fit: BoxFit.cover,
                              loadingBuilder: ((
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Container(color: Colors.grey);
                              }),
                            ),
                            const SizedBox(height: 5),
                            Text(coupon.title!),
                            Text(coupon.name!),
                            Text(coupon.categoryName!),
                            ElevatedButton(
                              onPressed: () {
                                showConfirmationAlert(
                                  context,
                                  mounted,
                                  coupon,
                                  userSnapshot.data,
                                  'vendor',
                                );
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                coupon.code!,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  children = errorScreen(snapshot.error.toString());
                } else {
                  children = loadingSpinner();
                }

                return Center(child: children);
              }),
            );
          } else if (userSnapshot.hasError) {
            return errorScreen(userSnapshot.error.toString());
          } else {
            return loadingSpinner();
          }
        }),
      ),
    );
  }
}
