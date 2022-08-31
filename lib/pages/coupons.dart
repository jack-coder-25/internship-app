import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/coupons.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({Key? key}) : super(key: key);

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
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

  @override
  Widget build(BuildContext context) {
    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Coupons",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<AvailableCouponsResponse>(
              future: ApiService.instance.getAvailableCoupons(
                userSnapshot.data!.authToken,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    padding: const EdgeInsets.all(8.0),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: snapshot.data!.data!.map((
                      AvailableCouponsData coupon,
                    ) {
                      return GridTile(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                              child: Image.network(
                                height: 140.0,
                                '${ApiConstants.uploadsPath}/${coupon.image}',
                                fit: BoxFit.cover,
                                loadingBuilder: ((
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Container(
                                    color: Colors.grey,
                                  );
                                }),
                                errorBuilder: (((context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Text(
                                      'Cannot Load Image',
                                    ),
                                  );
                                })),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              coupon.title ?? '--',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: coupon.code),
                                );
                                if (!mounted) return;
                                showSnackbar(
                                  context,
                                  'Code Copied',
                                );
                              },
                              style: buttonStyle,
                              child: Text(
                                coupon.code ?? '--',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
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
