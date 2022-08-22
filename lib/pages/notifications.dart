import 'package:app/constants/colors.dart';
import 'package:app/models/notifications.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<NotificationResponse>(
              future: ApiService.instance.getUserNotifications(
                userSnapshot.data!.authToken,
                userSnapshot.data!.accountType,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  if (snapshot.data!.data!.isEmpty) {
                    children = const Text('No Notifications.');
                  } else {
                    children = ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (((context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data!.data![index].title!,
                          ),
                          subtitle: Text(
                            snapshot.data!.data![index].description!,
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
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
    );
  }
}
