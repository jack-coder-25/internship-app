import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/functions.dart';
import 'package:mci/utils/helper.dart';
import 'package:mci/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/utils/checkout.dart';
import 'package:provider/provider.dart';

class WalletTopupPageArguments {
  final String? amount;

  WalletTopupPageArguments({
    required this.amount,
  });
}

class WalletTopupPage extends StatefulWidget {
  const WalletTopupPage({Key? key}) : super(key: key);

  @override
  State<WalletTopupPage> createState() => _WalletTopupPageState();
}

class _WalletTopupPageState extends State<WalletTopupPage> {
  UserObject? user;
  late WalletTopupPageArguments? args;
  var amountTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var modalRoute = ModalRoute.of(context);
      args = modalRoute?.settings.arguments as WalletTopupPageArguments?;

      setState(() {
        user = context.read<UserObject?>();
        amountTextController = TextEditingController(text: args?.amount);
      });
    });
  }

  void onPayment() async {
    String accessKey =
        "a562d431d9cb5e54ff355973fe86e20d2a64400ed0ce9bb7522904c57c8acff9";
    final paymentResponse = await makePayment(accessKey);

    if (paymentResponse['payment_response']['status'] == 'success') {
      String transcationId = generateRandomString(8);

      await ApiService.instance.topupWallet(
        user!.authToken,
        user!.accountType,
        transcationId,
        amountTextController.text,
      );

      if (!mounted) return;
      showSnackbar(context, 'Money added sucessfully!');
      Navigator.pop(context);
    } else {
      if (!mounted) return;

      showSnackbar(
        context,
        paymentResponse['payment_response']['error'] ?? 'Something went wrong',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Topup'),
        backgroundColor: ColorConstants.red,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: ColorConstants.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              Icons.wallet,
              size: 128.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 250,
            child: TextFormField(
              validator: validateNotEmpty('Amount'),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: amountTextController,
              decoration: const InputDecoration(
                prefixText: '\u{20B9}',
                fillColor: Colors.white,
                prefixStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
                hintText: 'Amount',
                focusColor: Colors.white,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: buttonStyleRed,
            onPressed: onPayment,
            child: const Text(
              "Add Money",
              style: TextStyle(
                color: ColorConstants.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
