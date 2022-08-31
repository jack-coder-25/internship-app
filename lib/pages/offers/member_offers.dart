import 'package:app/styles/buttton.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/offers.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

class MemberOffersPage extends StatefulWidget {
  const MemberOffersPage({Key? key}) : super(key: key);

  @override
  State<MemberOffersPage> createState() => _MemberOffersPageState();
}

class _MemberOffersPageState extends State<MemberOffersPage> {
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
    const Tab(text: 'Vendor Offers'),
    const Tab(text: 'General Offers'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Offers'),
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
            VendorOffersGrid(),
            GeneralOffersGrid(),
          ],
        ),
      ),
    );
  }
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

void showConfirmationAlert(
  BuildContext context,
  bool mounted,
  VendorOfferData offer,
  UserObject? user,
) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: const Text(
        'Offer',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 300.0,
        width: 380.0,
        child: Column(
          children: [
            Image.network(
              height: 140.0,
              '${ApiConstants.uploadsPath}/${offer.image!}',
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
            const SizedBox(
              height: 20,
            ),
            Text(offer.title ?? '-'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ApiService.instance.claimOffer(
                    user!.authToken,
                    offer.id!,
                  );
                  if (!mounted) return;
                  showSnackbar(context, 'Offer Claimed Successfully');
                } catch (error) {
                  showSnackbar(context, error.toString());
                } finally {
                  Navigator.pop(context);
                }
              },
              style: buttonStyle,
              child: const Text('Claim'),
            ),
          ],
        ),
      ),
    ),
  );
}

class VendorOffersGrid extends StatefulWidget {
  const VendorOffersGrid({Key? key}) : super(key: key);

  @override
  State<VendorOffersGrid> createState() => _VendorOffersGridState();
}

class _VendorOffersGridState extends State<VendorOffersGrid> {
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
            return FutureBuilder<VendorOffersResponse>(
              future: ApiService.instance.getVendorOffers(
                userSnapshot.data!.authToken,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: snapshot.data!.data!.map((
                      VendorOfferData offer,
                    ) {
                      return GridTile(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Image.network(
                                height: 140.0,
                                '${ApiConstants.uploadsPath}/${offer.image!}',
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
                            ),
                            const SizedBox(height: 5),
                            Text(
                              offer.title ?? '-',
                              maxLines: 2,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showConfirmationAlert(
                                  context,
                                  mounted,
                                  offer,
                                  userSnapshot.data!,
                                );
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                offer.couponCode!,
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

class GeneralOffersGrid extends StatefulWidget {
  const GeneralOffersGrid({Key? key}) : super(key: key);

  @override
  State<GeneralOffersGrid> createState() => _GeneralOffersGridState();
}

class _GeneralOffersGridState extends State<GeneralOffersGrid> {
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
            return FutureBuilder<GeneralOffersResponse>(
              future: ApiService.instance.getGeneralOffers(
                userSnapshot.data!.authToken,
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
                    children:
                        snapshot.data!.data!.map((GeneralOfferData offer) {
                      return GridTile(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Image.network(
                                height: 140.0,
                                '${ApiConstants.uploadsPath}/${offer.image}',
                                fit: BoxFit.cover,
                                loadingBuilder: ((
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Container(color: Colors.grey);
                                }),
                                errorBuilder: (((context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Text('Cannot Load Image'),
                                  );
                                })),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              offer.title ?? '--',
                              style: const TextStyle(
                                fontSize: 20,
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
