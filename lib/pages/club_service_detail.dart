import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/constants/colors.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/user.dart';
import 'package:app/models/vendor.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

class ClubServicesDetailPageArguments {
  String vendorCategoryId;

  ClubServicesDetailPageArguments({
    required this.vendorCategoryId,
  });
}

class ClubServicesDetailPage extends StatefulWidget {
  const ClubServicesDetailPage({Key? key}) : super(key: key);

  @override
  State<ClubServicesDetailPage> createState() => _ClubServicesDetailPageState();
}

const String pattern = 'yyyy-MM-dd';
final now = DateTime.now();

class _ClubServicesDetailPageState extends State<ClubServicesDetailPage> {
  ClubServicesDetailPageArguments? args;
  final controller = PageController();
  DatePickerController datePickerController = DatePickerController();
  bool isLastPage = false;
  int selectedCategory = 0;
  List<VendorServiceSlotsData> selectedSlots = [];
  VendorServiceSlotsData? selectedSlot;
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (args == null && args?.vendorCategoryId == null) {
        var modalRoute = ModalRoute.of(context);
        args =
            modalRoute?.settings.arguments as ClubServicesDetailPageArguments;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget loadingSpinner() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: ColorConstants.red,
          ),
        ],
      ),
    );
  }

  Widget errorScreen(String? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(error ?? "Something went wrong"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    Future<VendorServicesResponse> getData(
      String authToken,
      String vendorCategoryId,
    ) async {
      var data = await ApiService.instance.getVendorServices(
        authToken,
        vendorCategoryId,
      );

      if (data.data!.isNotEmpty) {
        return data;
      } else {
        return Future.error('Service does not exist.');
      }
    }

    return Scaffold(
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<VendorServicesResponse>(
              future: getData(
                userSnapshot.data!.authToken,
                args!.vendorCategoryId,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  var categories = snapshot.data!.data!;
                  var slides = snapshot.data!.data![selectedCategory].slides;

                  var now = DateTime.now();
                  DateTime startDate = now;
                  DateTime endDate = now.add(const Duration(days: 30));

                  children = SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 220.0,
                              child: slides!.isNotEmpty
                                  ? PageView(
                                      controller: controller,
                                      onPageChanged: (index) {
                                        setState(() {
                                          isLastPage =
                                              index == slides.length - 1;
                                        });
                                      },
                                      children: slides
                                          .map(
                                            (slide) => Center(
                                              child: Image.network(
                                                "${ApiConstants.uploadsPath}/${slide.image}",
                                                width: double.infinity,
                                                height: 220.0,
                                                fit: BoxFit.cover,
                                                errorBuilder: (((
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return const Center(
                                                    child: Text(
                                                      'Cannot Load Image',
                                                    ),
                                                  );
                                                })),
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
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: const Center(
                                        child: Text('No Image'),
                                      ),
                                    ),
                            ),
                            Visibility(
                              visible: slides.isNotEmpty,
                              child: Positioned(
                                bottom: 15,
                                child: SmoothPageIndicator(
                                  controller: controller,
                                  count: slides.length,
                                  effect: const WormEffect(
                                    activeDotColor: Color.fromARGB(
                                      255,
                                      255,
                                      0,
                                      0,
                                    ),
                                    dotColor: Colors.black,
                                    spacing: 16,
                                  ),
                                  onDotClicked: ((index) =>
                                      controller.animateToPage(
                                        index,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.easeIn,
                                      )),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 0,
                              child: BackButton(
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        GridView.count(
                          crossAxisCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: categories.mapIndexed((index, category) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = index;
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: ColorConstants.red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        category.title ?? '-',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${snapshot.data!.data![selectedCategory].amount}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: ColorConstants.red,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.data!.data![selectedCategory]
                                        .shortNotes ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Html(
                                data: snapshot.data!.data![selectedCategory]
                                        .description ??
                                    '',
                                style: {
                                  'body': Style(
                                    margin: const EdgeInsets.all(0),
                                  )
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: snapshot.data!.data![selectedCategory]
                                          .mapLink !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: InkWell(
                                        onTap: () async {
                                          await launchUrl(
                                            Uri.parse(
                                              snapshot
                                                  .data!
                                                  .data![selectedCategory]
                                                  .mapLink!,
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.location_on,
                                          size: 32,
                                        ),
                                      ),
                                    )
                                  : null,
                            )
                          ],
                        ),
                        Container(
                          child: snapshot.data!.data![selectedCategory]
                                  .amenities!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Amenities",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: snapshot.data!
                                          .data![selectedCategory].amenities!
                                          .map(
                                            (item) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  top: 6.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: Image.network(
                                                      "${ApiConstants.uploadsPath}/${item.icon}",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(item.title ?? '-')
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: snapshot.data!.data![selectedCategory]
                                  .rulesRegulations!.isNotEmpty
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          "Rules & Regulations",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        itemCount: snapshot
                                            .data!
                                            .data![selectedCategory]
                                            .rulesRegulations!
                                            .length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (((
                                          context,
                                          index,
                                        ) {
                                          var item = snapshot
                                              .data!
                                              .data![selectedCategory]
                                              .rulesRegulations![index];

                                          return Row(
                                            children: [Text(item)],
                                          );
                                        })),
                                      )
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.grey,
                          alignment: Alignment.topCenter,
                          child: HorizontalDatePickerWidget(
                            startDate: startDate,
                            endDate: endDate,
                            selectedDate: now,
                            widgetWidth: MediaQuery.of(context).size.width,
                            datePickerController: datePickerController,
                            onValueSelected: (dateTime) async {
                              var date = DateFormat(pattern).format(dateTime);

                              try {
                                var slots = await ApiService.instance
                                    .getVendorServiceSlots(
                                  userSnapshot.data!.authToken,
                                  snapshot.data!.data![selectedCategory].id!,
                                  date,
                                );

                                setState(() {
                                  selectedSlots = slots.data!;
                                  quantity = 1;
                                });
                              } catch (error) {
                                showSnackbar(context, 'Error fetching slots');
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: selectedSlots.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  GridView.count(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2.5,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: selectedSlots.map((slot) {
                                      return GridTile(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedSlot = slot;
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                selectedSlot?.title ==
                                                        slot.title
                                                    ? Colors.black
                                                    : Colors.white,
                                            fixedSize: const Size(100, 36),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            slot.title!,
                                            style: TextStyle(
                                              color: selectedSlot?.title ==
                                                      slot.title
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Visibility(
                                    visible: selectedSlot != null,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  const TextSpan(
                                                    text: 'Available Qty: ',
                                                  ),
                                                  TextSpan(
                                                    text: selectedSlot
                                                            ?.qtyAvailable ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: ColorConstants.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            QuantityInput(
                                              value: quantity,
                                              minValue: 1,
                                              maxValue: int.parse(
                                                selectedSlot?.qtyAvailable ??
                                                    '1',
                                              ),
                                              onChanged: (value) => setState(
                                                () => quantity = int.parse(
                                                    value.replaceAll(',', '')),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '₹ ${(double.parse(snapshot.data!.data![selectedCategory].amount!) * quantity)}',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: (int.parse(
                                        selectedSlot?.qtyAvailable ?? '0')) >
                                    0
                                ? () async {
                                    try {
                                      await ApiService.instance.bookService(
                                        userSnapshot.data!.authToken,
                                        selectedSlot!.serviceId!,
                                        selectedSlot!.id!,
                                        quantity.toString(),
                                      );

                                      if (!mounted) return;
                                      showSnackbar(context, 'Service Booked!');

                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/auth",
                                        (r) => false,
                                      );
                                    } catch (error) {
                                      showSnackbar(context, 'Cannot book now!');
                                    }
                                  }
                                : null,
                            child: const Text(
                              'Book Service',
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  children = errorScreen(snapshot.error.toString());
                } else {
                  children = loadingSpinner();
                }

                return Container(child: children);
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
