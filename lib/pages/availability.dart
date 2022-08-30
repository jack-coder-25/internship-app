import 'package:app/constants/colors.dart';
import 'package:app/models/user.dart';
import 'package:app/models/vendor.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({Key? key}) : super(key: key);

  @override
  State<AvailabilityPage> createState() => _BusinessBookingsPage();
}

const String pattern = 'yyyy-MM-dd';
final now = DateTime.now();

class _BusinessBookingsPage extends State<AvailabilityPage> {
  var categoryId = '';
  CategoryData? selectedCategory;
  var serviceDate = DateFormat(pattern).format(now);

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
      appBar: AppBar(
        title: const Text('Availability'),
        backgroundColor: ColorConstants.red,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Services: ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
            const SizedBox(
              height: 15,
            ),
            FutureBuilder<UserObject?>(
              future: getUser(),
              builder: ((context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return FutureBuilder<VendorServicesResponse>(
                    future: ApiService.instance.getServices(
                      userSnapshot.data!.authToken,
                      categoryId,
                    ),
                    builder: ((context, servicesSnapshot) {
                      if (servicesSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return loadingSpinner();
                      }

                      if (servicesSnapshot.hasData) {
                        selectedCategory ??= servicesSnapshot.data!.data?[0];

                        return FutureBuilder<VendorServiceSlotsResponse>(
                          future: ApiService.instance.getServiceSlots(
                            userSnapshot.data!.authToken,
                            selectedCategory!.id!,
                            serviceDate,
                          ),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return loadingSpinner();
                            }

                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<CategoryData>(
                                          elevation: 0,
                                          value: selectedCategory,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          isDense: true,
                                          items: servicesSnapshot.data!.data!
                                              .map((item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                item.title!,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (CategoryData? newValue) {
                                            setState(() {
                                              selectedCategory = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          var pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2100),
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary: ColorConstants.red,
                                                    onPrimary: Colors.white,
                                                    onSurface: Colors.black,
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (pickedDate != null) {
                                            setState(() {
                                              serviceDate = DateFormat(pattern)
                                                  .format(pickedDate);
                                            });
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              serviceDate,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.455,
                                    child: snapshot.data!.data!.isNotEmpty
                                        ? ListView.separated(
                                            itemCount:
                                                snapshot.data!.data!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            itemBuilder: (((context, index) {
                                              var item =
                                                  snapshot.data!.data![index];

                                              return ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.title!,
                                                      style: const TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                        ),
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                'Start Date: ',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${item.startAt}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  ColorConstants
                                                                      .red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                        ),
                                                        children: [
                                                          const TextSpan(
                                                            text: 'End Date: ',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${item.endAt}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  ColorConstants
                                                                      .red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5,
                                                              ),
                                                            ),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    ColorConstants
                                                                        .red,
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              5.0,
                                                            ),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        'Total: ',
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        '${item.qtyTotal}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: ColorConstants
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5,
                                                              ),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    ColorConstants
                                                                        .red,
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              5.0,
                                                            ),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        'Pending: ',
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        '${item.qtyAvailable}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: ColorConstants
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                5,
                                                              ),
                                                            ),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    ColorConstants
                                                                        .red,
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              5.0,
                                                            ),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        'Booked: ',
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        '${item.qtyBooked}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      color: ColorConstants
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: buttonStyle,
                                                        child: const Text(
                                                          'Delete',
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(
                                                  5.0,
                                                ),
                                              );
                                            })),
                                          )
                                        : Column(
                                            children: const [
                                              Text(
                                                'No Bookings',
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return errorScreen(
                                snapshot.error.toString(),
                              );
                            } else {
                              return loadingSpinner();
                            }
                          }),
                        );
                      } else if (servicesSnapshot.hasError) {
                        return errorScreen(
                          servicesSnapshot.error.toString(),
                        );
                      } else {
                        return loadingSpinner();
                      }
                    }),
                  );
                } else if (userSnapshot.hasError) {
                  return errorScreen(
                    userSnapshot.error.toString(),
                  );
                } else {
                  return loadingSpinner();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
