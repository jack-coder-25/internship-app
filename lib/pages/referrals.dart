import 'package:mci/constants/colors.dart';
import 'package:mci/models/dashboard.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:mci/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

class ReferralsPage extends StatefulWidget {
  const ReferralsPage({Key? key}) : super(key: key);

  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
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

  String dropdownValue = 'All';
  var items = ['All', 'Paid', 'Unpaid'];

  void referFriend() async {
    var user = await getUser();

    if (user?.profile?.data?.referralCode != null) {
      await FlutterShare.share(
        title: 'Referral Code',
        chooserTitle: 'Invite Friends',
        text: '''Hi, use my referral code -
        ${user!.profile!.data!.referralCode}''',
      );
    } else {
      if (!mounted) return;
      showSnackbar(context, 'Referral Code Not Available!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Referrals',
          style: TextStyle(
            color: Colors.black,
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
              return FutureBuilder<DashboardSummaryResponse>(
                future: ApiService.instance.getSummaryDashboard(
                  userSnapshot.data!.authToken,
                  userSnapshot.data!.accountType,
                ),
                builder: ((context, snapshot) {
                  Widget children;

                  if (snapshot.hasData) {
                    if (snapshot.data!.data!.referrals!.total!.isEmpty) {
                      children = const Text('No Referrals.');
                    } else {
                      List<ReferralItem>? referrals;

                      if (dropdownValue == 'All') {
                        referrals = snapshot.data!.data!.referrals!.total;
                      } else if (dropdownValue == 'Paid') {
                        referrals = snapshot.data!.data!.referrals!.paid;
                      } else {
                        referrals = snapshot.data!.data!.referrals!.unpaid;
                      }

                      children = ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        itemCount: referrals!.length,
                        itemBuilder: (((context, index) {
                          return ListTile(
                            title: Text(
                              referrals![index].name!,
                            ),
                            subtitle: Text(
                              referrals[index].referralCommission!,
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
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isDense: true,
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
                        height: MediaQuery.of(context).size.height / 1.45,
                        child: children,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(10, 40),
                              textStyle: const TextStyle(fontSize: 18),
                              primary: Colors.orange,
                              onPrimary: Colors.white,
                            ),
                            onPressed: referFriend,
                            child: const Text("Refer your Friend"),
                          ),
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
