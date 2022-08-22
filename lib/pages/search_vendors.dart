import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/search.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
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
      drawer: const Drawer(),
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
                      children = GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .82,
                        padding: const EdgeInsets.all(4.0),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 4.0,
                        children: snapshot.data!.data!.map((Data vendor) {
                          return GridTile(
                            child: Column(
                              children: [
                                Image.network(
                                  height: 140.0,
                                  '${ApiConstants.uploadsPath}/${vendor.photo}',
                                  fit: BoxFit.cover,
                                  errorBuilder: ((context, error, stackTrace) {
                                    return const SizedBox(
                                      height: 140.0,
                                      child: Center(
                                        child: Text('No Image'),
                                      ),
                                    );
                                  }),
                                  loadingBuilder: ((
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 140.0,
                                      color: Colors.grey,
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  vendor.name ?? '',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        }).toList(),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: children,
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
