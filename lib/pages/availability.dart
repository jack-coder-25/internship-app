import 'dart:convert';
import 'package:mci/constants/colors.dart';
import 'package:mci/main.dart';
import 'package:mci/models/categories.dart';
import 'package:mci/models/user.dart';
import 'package:mci/models/vendor.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/utils/helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quantity_input/quantity_input.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({Key? key}) : super(key: key);

  @override
  State<AvailabilityPage> createState() => _BusinessBookingsPage();
}

const String pattern = 'yyyy-MM-dd';
final now = DateTime.now();

Widget loadingSpinner() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Center(
        child: CircularProgressIndicator(
          color: ColorConstants.red,
        ),
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

Future<DateTime?> showDatePickerDialog(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.red,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}

Future<TimeOfDay?> showTimePickerDialog(BuildContext context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.red,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}

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
        child: FutureBuilder<UserObject?>(
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
                                  const Text(
                                    'Your Services: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
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
                                        builder: (context) => AddServiceSheet(
                                          userObject: userSnapshot.data!,
                                          onComplete: () {
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                        ),
                                      );
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<CategoryData>(
                                      elevation: 0,
                                      value: selectedCategory,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      isDense: true,
                                      items: servicesSnapshot.data!.data?.map((
                                        item,
                                      ) {
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
                                      var pickedDate =
                                          await showDatePickerDialog(
                                        context,
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
                                            fontWeight: FontWeight.normal,
                                          ),
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
                                height:
                                    MediaQuery.of(context).size.height / 1.455,
                                child: snapshot.data!.data!.isNotEmpty
                                    ? ListView.separated(
                                        itemCount: snapshot.data!.data!.length,
                                        separatorBuilder: (context, index) =>
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
                                                        text: 'Start Date: ',
                                                      ),
                                                      TextSpan(
                                                        text: '${item.startAt}',
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: ColorConstants
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
                                                        text: '${item.endAt}',
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: ColorConstants
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
                                                            BorderRadius.all(
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
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: [
                                                              const TextSpan(
                                                                text: 'Total: ',
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    '${item.qtyTotal}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  color:
                                                                      ColorConstants
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
                                                            BorderRadius.all(
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
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
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
                                                                  color:
                                                                      ColorConstants
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
                                                            BorderRadius.all(
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
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
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
                                                                  color:
                                                                      ColorConstants
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
                                                    onPressed: () async {
                                                      try {
                                                        await ApiService
                                                            .instance
                                                            .deleteServiceSlot(
                                                          userSnapshot
                                                              .data!.authToken,
                                                          item.id!,
                                                        );
                                                        setState(() {});
                                                      } catch (error) {
                                                        showSnackbar(
                                                          context,
                                                          'Cannot Delete Service Slot',
                                                        );
                                                      }
                                                    },
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
                                            style: TextStyle(fontSize: 16.0),
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
      ),
    );
  }
}

class AddServiceSheet extends StatefulWidget {
  final UserObject userObject;
  final Function onComplete;

  const AddServiceSheet({
    Key? key,
    required this.userObject,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<AddServiceSheet> {
  final descriptionTextController = TextEditingController();
  String? selectedCategoryId;
  String? selectedServiceId;
  String? startDate;
  String? endDate;

  List<Map<String, dynamic>> timePeriods = [
    {
      "title": "",
      "qty": '1',
      "start_time": null,
      "end_time": null,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.035,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          child: const Icon(Icons.close),
                        ),
                        const Text(
                          'Add Service',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<CategoriesResponse>(
                      future: ApiService.instance.getCategories(
                        userObject?.authToken ?? '-',
                      ),
                      builder: (((context, snapshot) {
                        if (snapshot.hasData) {
                          selectedCategoryId ??= snapshot.data!.data?[0].id;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  elevation: 0,
                                  value: selectedCategoryId,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  isDense: true,
                                  items: snapshot.data!.data?.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Text(
                                        item.title!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategoryId = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return errorScreen(snapshot.error.toString());
                        } else {
                          return loadingSpinner();
                        }
                      })),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<VendorServicesResponse>(
                      future: ApiService.instance.getServices(
                        userObject!.authToken,
                        selectedCategoryId ?? '',
                      ),
                      builder: (((context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.data!.isEmpty) {
                            selectedServiceId = null;
                          } else {
                            selectedServiceId ??= snapshot.data?.data?[0].id;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  elevation: 0,
                                  value: selectedServiceId,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text('No Services'),
                                  isDense: true,
                                  items: snapshot.data!.data?.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Text(
                                        item.title!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedServiceId = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return errorScreen(snapshot.error.toString());
                        } else {
                          return const SizedBox();
                        }
                      })),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePickerDialog(
                              context,
                            );

                            if (pickedDate != null) {
                              setState(() {
                                startDate = DateFormat(pattern).format(
                                  pickedDate,
                                );
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                startDate ?? 'Select Start Date',
                                style: const TextStyle(
                                  color: ColorConstants.red,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.access_time_outlined,
                                color: ColorConstants.red,
                              )
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.swap_horiz_rounded,
                          size: 32.0,
                        ),
                        TextButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePickerDialog(
                              context,
                            );

                            if (pickedDate != null) {
                              setState(() {
                                endDate = DateFormat(pattern).format(
                                  pickedDate,
                                );
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                endDate ?? 'Select End Date',
                                style: const TextStyle(
                                  color: ColorConstants.red,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.access_time_outlined,
                                color: ColorConstants.red,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            timePeriods.add({
                              "title": "",
                              "qty": '1',
                              "start_time": null,
                              "end_time": null,
                            });
                          });
                        },
                        style: buttonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.add),
                            Text('Add Time'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: timePeriods.mapIndexed(
                        (
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
                                            hintText: 'Title',
                                          ),
                                          initialValue: timePeriods[index]
                                              ['title'],
                                          onChanged: (title) {
                                            setState(() {
                                              timePeriods[index]['title'] =
                                                  title;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePickerDialog(
                                        context,
                                      );

                                      if (pickedTime != null) {
                                        final now = DateTime.now();

                                        var dt = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );

                                        setState(() {
                                          timePeriods[index]['start_time'] =
                                              DateFormat('HH:mm').format(dt);
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          timePeriods[index]['start_time'] ??
                                              'Select Start Time',
                                          style: const TextStyle(
                                            color: ColorConstants.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.access_time_outlined,
                                          color: ColorConstants.red,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.swap_horiz_rounded,
                                    size: 32.0,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePickerDialog(
                                        context,
                                      );

                                      if (pickedTime != null) {
                                        final now = DateTime.now();

                                        var dt = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );

                                        setState(() {
                                          timePeriods[index]['end_time'] =
                                              DateFormat('HH:mm').format(dt);
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          timePeriods[index]['end_time'] ??
                                              'Select End Time',
                                          style: const TextStyle(
                                            color: ColorConstants.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.access_time_outlined,
                                          color: ColorConstants.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  QuantityInput(
                                    minValue: 1,
                                    value:
                                        int.parse(timePeriods[index]['qty']!),
                                    onChanged: (value) {
                                      setState(() {
                                        timePeriods[index]['qty'] = value;
                                      });
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        timePeriods.removeAt(index);
                                      });
                                    },
                                    style: buttonStyle,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Icon(Icons.delete),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: selectedServiceId != null &&
                                startDate != null &&
                                endDate != null
                            ? () async {
                                try {
                                  await ApiService.instance.addServiceSlots(
                                    userObject!.authToken,
                                    selectedServiceId!,
                                    startDate!,
                                    endDate!,
                                    json.encode(timePeriods),
                                  );

                                  if (!mounted) return;
                                  showSnackbar(context, 'Service Added');
                                } catch (error) {
                                  showSnackbar(context, error.toString());
                                } finally {
                                  widget.onComplete();
                                }
                              }
                            : null,
                        style: buttonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.done),
                            Text('Submit'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
