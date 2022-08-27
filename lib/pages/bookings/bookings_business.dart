import 'package:app/constants/colors.dart';
import 'package:app/models/bookings.dart';
import 'package:app/models/user.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessBookingsPage extends StatefulWidget {
  const BusinessBookingsPage({Key? key}) : super(key: key);

  @override
  State<BusinessBookingsPage> createState() => _BusinessBookingsPage();
}

const String pattern = 'yyyy-MM-dd';
final now = DateTime.now();

class _BusinessBookingsPage extends State<BusinessBookingsPage> {
  DatePickerController datePickerController = DatePickerController();
  var selectedDate = DateFormat(pattern).format(now);
  DateTime startDate = now.subtract(const Duration(days: 365));
  DateTime endDate = now.add(const Duration(days: 365));

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            alignment: Alignment.topCenter,
            child: HorizontalDatePickerWidget(
              startDate: startDate,
              endDate: endDate,
              selectedDate: DateTime.parse(selectedDate),
              widgetWidth: MediaQuery.of(context).size.width,
              datePickerController: datePickerController,
              onValueSelected: (date) {
                setState(() {
                  selectedDate = DateFormat(pattern).format(date);
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<UserObject?>(
            future: getUser(),
            builder: ((context, userSnapshot) {
              if (userSnapshot.hasData) {
                return FutureBuilder<BusinessBookingsReponse>(
                  future: ApiService.instance.getBusinessBookings(
                    userSnapshot.data!.authToken,
                    selectedDate,
                  ),
                  builder: ((context, snapshot) {
                    Widget children;

                    if (snapshot.connectionState != ConnectionState.done) {
                      return loadingSpinner();
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isEmpty) {
                        children = const Text('No Bookings.');
                      } else {
                        children = SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (((context, index) {
                              var status = snapshot.data!.data![index].status;
                              return ListTile(
                                visualDensity: const VisualDensity(vertical: 3),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.data![index].name!,
                                    ),
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Booking ID: '),
                                          TextSpan(
                                            text:
                                                snapshot.data!.data![index].id!,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: ColorConstants.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Status: '),
                                          TextSpan(
                                            text: status,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: ColorConstants.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Date: '),
                                          TextSpan(
                                            text: snapshot
                                                .data!.data![index].startAt!,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: ColorConstants.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: status == 'COMPLETED'
                                          ? null
                                          : () {
                                              if (status == 'BOOKED') {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        10.0,
                                                      ),
                                                      topRight: Radius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                        return Text('test');
                                                      },
                                                );
                                              } else {}
                                            },
                                      style: buttonStyle,
                                      child: Text(
                                        status == 'BOOKED'
                                            ? 'START SERVICE'
                                            : status == 'ONGOING'
                                                ? 'BILLING'
                                                : 'COMPLETED',
                                      ),
                                    )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(10.0),
                              );
                            })),
                          ),
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
        ],
      ),
    );
  }
}
