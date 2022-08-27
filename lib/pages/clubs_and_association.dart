import 'package:app/constants/constants.dart';
import 'package:app/pages/club_detail.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/search.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:provider/provider.dart';

class ClubsAndAssociationsPage extends StatefulWidget {
  const ClubsAndAssociationsPage({Key? key}) : super(key: key);

  @override
  State<ClubsAndAssociationsPage> createState() =>
      _ClubsAndAssociationsPageState();
}

class _ClubsAndAssociationsPageState extends State<ClubsAndAssociationsPage> {
  Future<UserObject?> getUser() async {
    AuthenticationService authService = context.read<AuthenticationService>();
    return (await authService.getUser());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Clubs and Association"),
        backgroundColor: ColorConstants.red,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: FutureBuilder<UserObject?>(
          future: getUser(),
          builder: ((context, userSnapshot) {
            if (userSnapshot.hasData) {
              return FutureBuilder<VendorSearchResponse>(
                future: ApiService.instance.searchVendors(
                  userSnapshot.data!.authToken,
                  '',
                  '',
                ),
                builder: ((context, snapshot) {
                  Widget children;

                  if (snapshot.hasData) {
                    if (snapshot.data!.data!.isEmpty) {
                      children = const Text('No Clubs Available.');
                    } else {
                      children = ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 8.0,
                              borderRadius: BorderRadius.circular(12.0),
                              child: InkWell(
                                onTap: () {
                                  var subscription = userSnapshot
                                      .data?.profile?.data?.subscription;

                                  var amcRequired = userSnapshot.data?.profile
                                      ?.data?.subscription?.amcRequired;

                                  if (subscription != null) {
                                    if (amcRequired == 'Yes') {
                                      showSnackbar(
                                        context,
                                        'Upgrade Subscription Plan',
                                      );

                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/subscription',
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        '/club-detail',
                                        arguments: ClubDetailPageArguments(
                                          vendorId:
                                              snapshot.data!.data![index].id!,
                                        ),
                                      );
                                    }
                                  } else {
                                    showSnackbar(
                                      context,
                                      'Subscription Required',
                                    );

                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/subscription',
                                    );
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 180,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          bottomLeft: Radius.circular(12.0),
                                        ),
                                        child: Image.network(
                                          "${ApiConstants.uploadsPath}/${snapshot.data!.data![index].photo}",
                                          fit: BoxFit.fill,
                                          loadingBuilder: ((
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              height: 120,
                                              width: 180,
                                              color: Colors.grey,
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                        ),
                                        child: Text(
                                          snapshot.data!.data![index].name!,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                      );
                    }
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
      ),
    );
  }
}
