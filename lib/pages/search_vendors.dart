import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/search.dart';
import 'package:app/models/user.dart';
import 'package:app/pages/club_detail.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

  String dropdownValue = '';
  TextEditingController searchTextController = TextEditingController();

  final items = [
    "Hotel",
    "Club",
    "Resort",
    "Saloon",
    "Parlour",
    "Service Apartments",
    "Textile",
    "Jewellery Shop",
    "SPA",
    "Marriage Hall",
    "Provision Bazzar",
    "Restaurant",
    "Cinema Online Tickets",
    "Online Discount Shopping",
    "Tours & Travels",
    "Gym",
    "Online Recharge",
    "Others",
    "Hotels and Resorts",
    "Electronices",
    "Mobile Phones",
    "Launday Services",
    "Medicines",
    "Beach Resort"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchTextController,
          decoration: InputDecoration(
            fillColor: Colors.black,
            hintText: 'Search',
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: const Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      extendBody: true,
      body: Center(
        child: FutureBuilder<UserObject?>(
          future: getUser(),
          builder: ((context, userSnapshot) {
            if (userSnapshot.hasData) {
              return FutureBuilder<VendorSearchResponse>(
                future: ApiService.instance.searchVendors(
                  userSnapshot.data!.authToken,
                  searchTextController.text,
                  dropdownValue,
                ),
                builder: ((context, snapshot) {
                  Widget children;

                  if (snapshot.hasData) {
                    if (snapshot.data!.data!.isEmpty) {
                      children = const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No Vendors Found',
                        ),
                      );
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

                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  3.0,
                                  2.0,
                                  3.0,
                                  2.0,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    elevation: 0,
                                    value: dropdownValue.isEmpty
                                        ? null
                                        : dropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isDense: true,
                                    menuMaxHeight: 400.0,
                                    hint: const Text('Select Category'),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(
                          parent: NeverScrollableScrollPhysics(),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.25,
                          child: children,
                        ),
                      )
                    ],
                  );
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
