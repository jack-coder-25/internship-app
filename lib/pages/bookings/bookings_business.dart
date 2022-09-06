import 'package:mci/constants/colors.dart';
import 'package:mci/models/bookings.dart';
import 'package:mci/models/user.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/utils/helper.dart';
import 'package:mci/utils/validation.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quantity_input/quantity_input.dart';

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

    void manageBooking(
      UserObject? userSnapshot,
      BusinessBookingsData booking,
    ) {
      if (booking.status == 'BOOKED') {
        final formKey = GlobalKey<FormState>();
        final otpTextController = TextEditingController();

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                10.0,
              ),
              topRight: Radius.circular(
                10.0,
              ),
            ),
          ),
          builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Start Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: 'Amount: '),
                          TextSpan(
                            text: '₹${booking.amount}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: ColorConstants.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        validator: validateNotEmpty('OTP'),
                        controller: otpTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                          focusColor: Colors.black,
                          hintText: 'OTP',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          if (otpTextController.text == booking.otp) {
                            try {
                              await ApiService.instance.startService(
                                userSnapshot!.authToken,
                                booking.id!,
                                booking.otp!,
                              );
                              if (!mounted) return;
                              Navigator.of(context).pop();
                              setState(() {});
                            } catch (error) {
                              showSnackbar(context, 'Cannot start service!');
                            }
                          } else {
                            showSnackbar(context, 'OTP not valid');
                          }
                        }
                      },
                      style: buttonStyle,
                      child: const Text('Start Service'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                10.0,
              ),
              topRight: Radius.circular(
                10.0,
              ),
            ),
          ),
          builder: (context) => BillingSheet(
            booking: booking,
            userObject: userSnapshot!,
            onComplete: () {
              Navigator.pop(context);
              setState(() {});
            },
          ),
        );
      }
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
                                    const SizedBox(height: 3),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Title: '),
                                          TextSpan(
                                            text: snapshot
                                                .data!.data![index].title,
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
                                          : () => manageBooking(
                                                userSnapshot.data,
                                                snapshot.data!.data![index],
                                              ),
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

class BillingSheet extends StatefulWidget {
  final BusinessBookingsData booking;
  final UserObject userObject;
  final Function onComplete;

  const BillingSheet({
    Key? key,
    required this.booking,
    required this.userObject,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BillingSheetState();
}

class _BillingSheetState extends State<BillingSheet> {
  final descriptionTextController = TextEditingController();

  List<Map<String, String>> services = [
    {'title': '', 'qty': '1', 'amount': ''},
  ];

  @override
  Widget build(BuildContext context) {
    double total = services
        .map<double>((e) =>
            double.parse(e["amount"]!.isEmpty ? "0" : e["amount"]!) *
            double.parse(e["qty"]!))
        .reduce((value, element) => value + element);

    var gst = (18 * total) / 100;
    var subTotal = total;
    total = total.toDouble() + gst;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.035,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Billing',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionTextController,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black87,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    focusColor: Colors.black,
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  DateFormat(pattern).format(
                    DateTime.parse(widget.booking.startAt!),
                  ),
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: ColorConstants.red,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Extra Services: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            services.add(
                              {
                                'title': '',
                                'qty': '1',
                                'amount': '',
                              },
                            );
                          });
                        },
                        style: buttonStyle,
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add Service'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: services.mapIndexed((
                    index,
                    service,
                  ) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black87,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      focusColor: Colors.black,
                                      hintText: 'Service Name',
                                    ),
                                    initialValue: services[index]['title'],
                                    onChanged: (title) {
                                      setState(() {
                                        services[index]['title'] = title;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefixText: '₹',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black87,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      focusColor: Colors.black,
                                      hintText: 'Per Price',
                                    ),
                                    initialValue: services[index]['amount'],
                                    onChanged: (amount) {
                                      setState(() {
                                        services[index]['amount'] = amount;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  QuantityInput(
                                    minValue: 1,
                                    value: int.parse(services[index]['qty']!),
                                    onChanged: (value) {
                                      setState(() {
                                        services[index]['qty'] = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '₹${int.parse(service['qty']!) * int.parse(service['amount']!.isEmpty ? '0' : service['amount']!)}',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: ColorConstants.red,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            services.removeAt(index);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: 'CGST: '),
                              TextSpan(
                                text: '9%',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: ColorConstants.red,
                                ),
                              ),
                              TextSpan(text: ', SGST: '),
                              TextSpan(
                                text: '9%',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: ColorConstants.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹$gst',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorConstants.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '₹$total',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorConstants.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: total > 0
                        ? () async {
                            var json = {};
                            var additonalServices = {};
                            var array = [];

                            for (var service in services) {
                              var arrayElem = {};
                              arrayElem["title"] = service['title'];
                              arrayElem["qty"] = service['qty'];
                              arrayElem["amount"] = service['amount'];
                              array.add(json);
                            }

                            additonalServices["amount_gst"] = gst;
                            additonalServices["amount_total"] = total;
                            additonalServices["amount_sub_total"] = subTotal;
                            additonalServices["services"] = array;

                            json["additional_services"] = additonalServices;
                            json["additional_amount"] = total;
                            json["booking_id"] = widget.booking.id;
                            json["remarks"] = descriptionTextController.text;

                            try {
                              await ApiService.instance.completeService(
                                widget.userObject.authToken,
                                widget.booking.id!,
                                json['additional_amount'].toString(),
                                json["additional_services"].toString(),
                                descriptionTextController.text,
                              );
                              if (!mounted) return;
                              showSnackbar(context, 'Service completed');
                            } catch (error) {
                              showSnackbar(context, 'Cannot complete service!');
                            } finally {
                              widget.onComplete();
                            }
                          }
                        : null,
                    style: buttonStyle,
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
