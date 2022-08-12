import 'package:app/constants/colors.dart';
import 'package:app/constants/temp.dart';
import 'package:app/styles/buttton.dart';
import 'package:flutter/material.dart';

class SubscriptionDetailPage extends StatefulWidget {
  const SubscriptionDetailPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Detail'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: ColorConstants.red,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.15,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 50,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    )
                  ],
                ),
              ),
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
                  height: 580,
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
                        const SizedBox(height: 20),
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
                          "Rs 1500 x 2 Worth Rejuvenate Spaâ€TMs 100% Free\nRs 500 x 2 Liquor cash redeem Coupon 100% Free\nRs 1000 worth Branded Provisions cash Coupon 100% Free\nRs 7000 Worth One Year Gym 100% Free @All Our BVC Clubs",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Allow Access To Our BVC Recreations For One Year\nGuest Rooms, Serviced Apartments, Indoor Games & Out Door Games, Swimming Pool, Cinema Indoor Theatre, Open Air Theatre, Kids Play Area, Party Hall, Conference Hall, Meeting Room, Restaurant, Garden Restaurant, Bar & Resto Bar.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Events & Programs                                                                 Dramas, Magic Shows, Musical Events, Cine Awards, New Year Events, Special Holiday Events, Fashion Shows, Food Feast, Family Workshops, Business Expo, Charity & Welfare Events, Business Events, Yearend Family Parties, Themed Parties & Ectâ€¦..",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            Temp.isBarAllowed = true;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/bottom-bar",
                              (r) => false,
                            );
                          },
                          child: const Text(
                            "Buy Plan",
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
