import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/offers.dart';
import 'package:app/models/slides.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/widget/drawer_widget/drawer_wrapper.dart';
import 'package:provider/provider.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
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

  Future<UserObject?> getUser() async {
    AuthenticationService authService = context.read<AuthenticationService>();
    return (await authService.getUser());
  }

  Future<VendorOffersResponse> getOffers() async {
    var user = await getUser();
    return await ApiService.instance.getVendorOffers(user!.authToken);
  }

  Widget loadingScreen() {
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

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: MaterialApp(
        home: Scaffold(
          drawer: const DrawerWrapper(),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FutureBuilder<UserObject?>(
                    future: getUser(),
                    builder: ((_, userSnapshot) {
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
                                    .map(
                                      (slide) => SizedBox(
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
                                      ),
                                    )
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
                              children = loadingScreen();
                            }

                            return Center(child: children);
                          }),
                        );
                      } else if (userSnapshot.hasError) {
                        return errorScreen(userSnapshot.error.toString());
                      } else {
                        return loadingScreen();
                      }
                    }),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  TextField(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      hintText: 'Search',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage('assets/images/drink1.jpg'),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () async {
                              var user = await getUser();
                              if (!mounted) return;

                              if (user?.profile?.data?.subscription != null) {
                                Navigator.pushNamed(context, '/bar-home');
                              } else {
                                Navigator.pushNamed(context, '/subscription');
                              }
                            },
                          ),
                        ),
                        const Text(
                          ' ', //buy a drinks
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  FutureBuilder<VendorOffersResponse>(
                    future: getOffers(),
                    builder: (((_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.data!.isEmpty) {
                          return Container(
                            color: Colors.grey,
                            child: const Text(
                              'No Offers at The Moment',
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: snapshot.data!.data!.map((offer) {
                                return FittedBox(
                                  fit: BoxFit.fill,
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/offers',
                                          );
                                        },
                                        child: Container(
                                          width: 200,
                                          margin: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          height: categoryHeight,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                fit: BoxFit.contain,
                                                '${ApiConstants.uploadsPath}/${offer.image}',
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  offer.title ?? '--',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return errorScreen(snapshot.error.toString());
                      } else {
                        return loadingScreen();
                      }
                    })),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage(
                            'assets/images/theclublogo-rm.jpg',
                          ),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/clubs-associations',
                              );
                            },
                          ),
                        ),
                        const Text(
                          '', //Our CLub and Association
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage(
                            'assets/images/luckydraw_banner.jpg',
                          ),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/spin-wheel');
                            },
                          ),
                        ),
                        const Text(
                          ' ', //lucky spin
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
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
      ),
    );
  }
}
