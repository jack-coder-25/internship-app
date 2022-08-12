import 'package:app/constants/temp.dart';
import 'package:app/widget/drawer_widget/drawer_wrapper.dart';
import 'package:flutter/material.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Wanna leave ?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No')),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: MaterialApp(
        home: Scaffold(
          drawer: const DrawerWrapper(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      labelText: 'Search',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage('assets/images/drink1.jpg'),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              if (Temp.isBarAllowed) {
                                Navigator.pushNamed(context, '/bar-home');
                              } else {
                                Navigator.pushNamed(context, '/subscription');
                              }
                            },
                          ),
                        ),
                        const Text(
                          ' ', //buy a drinks
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/subscription');
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 20),
                                height: categoryHeight,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Coupon",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/subscription');
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 20),
                                height: categoryHeight,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.shade400,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Coupon",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/subscription');
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.only(right: 20),
                                height: categoryHeight,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade800,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Coupon",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage(
                              'assets/images/theclublogo-rm.jpg'),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/clubs-associations',
                              );
                            },
                          ),
                        ),
                        const Text(
                          '', //Our CLub and Association
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(
                          image: const AssetImage(
                            'assets/images/luckydraw_banner.jpg',
                          ),
                          height: 180,
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    color: const Color.fromARGB(
                                      255,
                                      230,
                                      229,
                                      227,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('Buy a plan'),
                                          ElevatedButton(
                                            child: const Text('Subscribe'),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/subscription');
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const Text(
                          ' ', //lucky spin
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(213, 116, 28, 28),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
