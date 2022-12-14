import 'package:mci/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:mci/models/slides.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/widget/drawer_widget/drawer_wrapper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:mci/constants/constants.dart';

class BusinessHomePage extends StatefulWidget {
  const BusinessHomePage({Key? key}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do You Want To Exit ?'),
          actions: [
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.red,
                fixedSize: const Size(48, 36),
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.red,
                fixedSize: const Size(48, 36),
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final items = context.read<List<String>>();
    final setSelectedIndex = context.read<void Function(int)>();

    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    Widget loadingSpinner() {
      return Container(
        height: 270,
        width: double.infinity,
        color: Colors.grey,
        child: null,
      );
    }

    Widget errorScreen(String? error) {
      return SizedBox(
        height: 270.0,
        child: Center(
          child: Text(error ?? "Something went wrong"),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        drawer: const DrawerWrapper(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder<UserObject?>(
                    future: getUser(),
                    builder: ((context, userSnapshot) {
                      if (userSnapshot.hasData) {
                        return FutureBuilder<SlidesResponse>(
                          future: ApiService.instance.getAppSlides(
                            userSnapshot.data!.authToken,
                            userSnapshot.data!.accountType,
                          ),
                          builder: ((context, snapshot) {
                            Widget children;

                            if (snapshot.hasData) {
                              children = CarouselSlider(
                                items: snapshot.data!.data!
                                    .map((slide) => SizedBox(
                                          child: Image.network(
                                            "${ApiConstants.uploadsPath}/${slide.image}",
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
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  height: 270.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(
                                    milliseconds: 800,
                                  ),
                                  viewportFraction: 0.8,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              children = errorScreen(
                                snapshot.error.toString(),
                              );
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 30,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/coupon-redemption');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 253, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.airplane_ticket,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Coupon Redemption",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.account_circle,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/offers');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.discount,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Offers",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/coupons');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.percent,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Coupons",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setSelectedIndex(
                              items.indexWhere(
                                (item) => item == 'Wallet',
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.wallet_membership,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setSelectedIndex(
                              items.indexWhere(
                                (item) => item == 'Bookings',
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.list,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Bookings",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/availability');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.history,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Availability",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setSelectedIndex(
                              items.indexWhere(
                                (item) => item == 'Support',
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.admin_panel_settings,
                                  size: 55,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Contact Admin",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
