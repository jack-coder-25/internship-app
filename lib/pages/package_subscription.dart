import 'package:app/constants/constants.dart';
import 'package:app/models/subscriptions.dart';
import 'package:app/pages/subscription_detail.dart';
import 'package:app/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/constants/colors.dart';
import 'package:provider/provider.dart';

class PackageSubscriptionPage extends StatefulWidget {
  const PackageSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<PackageSubscriptionPage> createState() =>
      _PackageSubscriptionPageState();
}

class _PackageSubscriptionPageState extends State<PackageSubscriptionPage> {
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
        title: const Text("Package Subscription"),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: const BackButton(
          color: Color.fromARGB(255, 251, 240, 240),
        ),
      ),
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<SubscriptionsResponse>(
              future: ApiService.instance.getSubscriptions(
                userSnapshot.data!.authToken,
                userSnapshot.data!.accountType,
              ),
              builder: (((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (((context, index) {
                      return Card(
                        color: Colors.grey,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Ink.image(
                              image: NetworkImage(
                                '${ApiConstants.uploadsPath}/${(snapshot.data!.data![index].cardBg!)}',
                              ),
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.6),
                                BlendMode.dstATop,
                              ),
                              height: 180,
                              fit: BoxFit.fill,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/subscription-detail',
                                    arguments: SubscriptionDetailPageArguments(
                                      subscription: snapshot.data!.data![index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Text(
                              snapshot.data!.data![index].title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(212, 255, 253, 253),
                                fontSize: 24,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(10.0, 10.0),
                                    blurRadius: 8.0,
                                    color: Color.fromARGB(255, 72, 33, 33),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
                  );
                } else if (snapshot.hasError) {
                  children = errorScreen(snapshot.error.toString());
                } else {
                  children = loadingSpinner();
                }

                return Center(child: children);
              })),
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
