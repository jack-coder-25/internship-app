import 'package:mci/constants/colors.dart';
import 'package:mci/constants/constants.dart';
import 'package:mci/models/brands.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnersPage extends StatefulWidget {
  const PartnersPage({Key? key}) : super(key: key);

  @override
  State<PartnersPage> createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
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
        title: const Text(
          "Our Partners",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<BrandsResponse>(
              future: ApiService.instance.getBrands(
                userSnapshot.data!.authToken,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: snapshot.data!.data!
                        .map(
                          (item) => GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${ApiConstants.uploadsPath}/${item.image}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Transform.translate(
                                    offset: const Offset(50, -50),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 65,
                                        vertical: 63,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
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
