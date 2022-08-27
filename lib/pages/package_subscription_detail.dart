import 'package:flutter/material.dart';

class PackageSubscriptionDetailPage extends StatefulWidget {
  const PackageSubscriptionDetailPage({Key? key}) : super(key: key);

  @override
  State<PackageSubscriptionDetailPage> createState() => _PackageSubscriptionDetailPageState();
}

class _PackageSubscriptionDetailPageState extends State<PackageSubscriptionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
              left: 20,
              top: 50,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )
                ],
              )),
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
              )),
          Positioned(
            top: 260,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 580,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "\$5000.00",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "ONE YEAR MEMBERSHIP",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "1) One-year subscription 17700. Ads will be displayed in the app random Wise                                                                          2) Every three months vendors can change the design on the app by getting design approval from the management.                                     3) 1 lakhs Whatsapp message to members / Charges 35400                          4) 1 lakhs SMS blast to the public via Pincode/ Charges 35400                                                 5) Second-year renewal 5900                                                                        6) Our royalty fee will be a minimum of 100 INR or 15 % value of the service taken by the customer.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      labelText: 'Enter Coupon',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      labelText: 'Enter Referal code',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: 250.0,
                    height: 60,
                    onPressed: () {},
                    color: const Color.fromARGB(255, 255, 0, 0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: 250.0,
                    height: 60,
                    onPressed: () {},
                    color: const Color.fromARGB(255, 255, 0, 0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
