import 'package:app/constants/colors.dart';
import 'package:app/models/user.dart';
import 'package:app/models/wallet.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  Future<UserObject?> getUser() async {
    AuthenticationService authService = context.read<AuthenticationService>();
    return (await authService.getUser());
  }

  Widget loadingSpinner() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error ?? "Something went wrong"),
      ],
    );
  }

  void withdrawCash() {}

  void depositCash() {
    Navigator.pushNamed(context, '/wallet-topup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const Drawer(),
      body: Center(
        child: FutureBuilder<UserObject?>(
          future: getUser(),
          builder: ((context, userSnapshot) {
            if (userSnapshot.hasData) {
              return FutureBuilder<WalletTransactionsResponse>(
                future: ApiService.instance.getUserTransactions(
                  userSnapshot.data!.authToken,
                  userSnapshot.data!.accountType,
                ),
                builder: ((context, snapshot) {
                  Widget children;
                  Widget topBar;

                  if (snapshot.hasData) {
                    if (snapshot.data!.data!.isEmpty) {
                      children = const Padding(
                        padding: EdgeInsets.all(16.0),
                        child:  Text('No Transcations'),
                      );
                    } else {
                      if (userSnapshot.data?.accountType ==
                          AccountType.member) {
                        children = SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.37,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (((context, index) {
                                    return ListTile(
                                      leading: Icon(
                                        snapshot.data!.data![index].type
                                                    ?.toLowerCase() ==
                                                'credit'
                                            ? Icons.south_west
                                            : Icons.north_east,
                                      ),
                                      title: Text(
                                        snapshot
                                            .data!.data![index].description!,
                                      ),
                                      subtitle: Text(
                                        snapshot.data!.data![index].createdAt!,
                                      ),
                                      trailing: Text(
                                        snapshot.data!.data![index].amount!,
                                        style: TextStyle(
                                          color: snapshot
                                                      .data!.data![index].type
                                                      ?.toLowerCase() ==
                                                  'credit'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        4.0,
                                        16.0,
                                        4.0,
                                      ),
                                    );
                                  })),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        children = SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.37,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (((context, index) {
                                    return ListTile(
                                      leading: Icon(
                                        snapshot.data!.data![index].type
                                                    ?.toLowerCase() ==
                                                'credit'
                                            ? Icons.south_west
                                            : Icons.north_east,
                                      ),
                                      title: Text(
                                        snapshot
                                            .data!.data![index].description!,
                                      ),
                                      subtitle: Text(
                                        snapshot.data!.data![index].createdAt!,
                                      ),
                                      trailing: Text(
                                        snapshot.data!.data![index].amount!,
                                        style: TextStyle(
                                          color: snapshot
                                                      .data!.data![index].type
                                                      ?.toLowerCase() ==
                                                  'credit'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        4.0,
                                        16.0,
                                        4.0,
                                      ),
                                    );
                                  })),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  } else if (snapshot.hasError) {
                    children = errorScreen(snapshot.error.toString());
                  } else {
                    children = loadingSpinner();
                  }

                  if (userSnapshot.data!.accountType == AccountType.member) {
                    String total;

                    if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
                      var credit = snapshot.data!.data!
                          .where((e) => e.type?.toLowerCase() == 'credit')
                          .map<double>((e) => double.parse(e.amount!))
                          .reduce((value, element) => value + element);

                      var debit = snapshot.data!.data!
                          .where((e) => e.type?.toLowerCase() == 'debit')
                          .map<double>((e) => double.parse(e.amount!))
                          .reduce((value, element) => value + element);

                      total = (credit - debit).toString();
                    } else {
                      total = '0';
                    }

                    topBar = Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '\u{20B9} $total',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Last Transaction - ${snapshot.data?.data?[0].amount ?? '...'}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: buttonStyleRed,
                            onPressed: depositCash,
                            child: const Text(
                              "Deposit Cash",
                              style: TextStyle(
                                color: ColorConstants.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    String total;

                    if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
                      total = snapshot.data!.data!
                          .where((e) => e.type?.toLowerCase() == 'credit')
                          .map<double>((e) => double.parse(e.amount!))
                          .reduce((value, element) => value + element)
                          .toString();
                    } else {
                      total = '0';
                    }

                    topBar = Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\u{20B9} $total',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: buttonStyleRed,
                            onPressed: withdrawCash,
                            child: const Text(
                              "Withdraw Cash",
                              style: TextStyle(
                                color: ColorConstants.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      topBar,
                      children,
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
