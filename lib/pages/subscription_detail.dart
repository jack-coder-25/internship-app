import 'package:app/models/user.dart';
import 'package:app/pages/wallet_topup.dart';
import 'package:app/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/subscriptions.dart';
import 'package:app/utils/helper.dart';
import 'package:app/constants/colors.dart';
import 'package:app/styles/buttton.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class SubscriptionDetailPageArguments {
  Data subscription;

  SubscriptionDetailPageArguments({
    required this.subscription,
  });
}

class SubscriptionDetailPage extends StatefulWidget {
  const SubscriptionDetailPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  SubscriptionDetailPageArguments? args;
  UserObject? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var modalRoute = ModalRoute.of(context);
      args = modalRoute?.settings.arguments as SubscriptionDetailPageArguments;
      user = context.read<UserObject?>();
      setState(() {});
    });
  }

  void onPayment() async {
    try {
      await ApiService.instance.subscribeToPlan(
        user!.authToken,
        user!.accountType,
        args!.subscription.id!,
        user?.referralCode,
      );

      if (!mounted) return;
      showSnackbar(context, 'Plan Subscribed Sucessfully');
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/auth",
        (r) => false,
      );
    } catch (error) {
      if (!mounted) return;

      if (error.toString().contains('balance')) {
        Navigator.pushNamed(
          context,
          '/wallet-topup',
          arguments: WalletTopupPageArguments(
            amount: args!.subscription.amount,
          ),
        );
      } else {
        showSnackbar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Detail'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: ColorConstants.red,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 1300,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 360,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/New-logo-red.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 260,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹${args?.subscription.amount}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          args?.subscription.title ?? '...',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Html(
                          data: args?.subscription.description ?? '',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: onPayment,
                            child: const Text(
                              "Buy",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
