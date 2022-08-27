import 'package:app/constants/colors.dart';
import 'package:app/models/bookings.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberBookingsPage extends StatefulWidget {
  const MemberBookingsPage({Key? key}) : super(key: key);

  @override
  State<MemberBookingsPage> createState() => _MemberBookingsPageState();
}

class _MemberBookingsPageState extends State<MemberBookingsPage> {
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
            return FutureBuilder<MemberBookingsReponse>(
              future: ApiService.instance.getMemberBookings(
                userSnapshot.data!.authToken,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  if (snapshot.data!.data!.isEmpty) {
                    children = const Text('No Bookings.');
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
                            snapshot.data!.data![index].vendorName!,
                          ),
                          subtitle: Text(
                            snapshot.data!.data![index].title!,
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!.data![index].status!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.0,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    const TextSpan(text: 'OTP: '),
                                    TextSpan(
                                      text: snapshot.data!.data![index].otp!,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: ColorConstants.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
