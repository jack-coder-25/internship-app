import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BarHomePage extends StatefulWidget {
  const BarHomePage({Key? key}) : super(key: key);

  @override
  State<BarHomePage> createState() => _BarHomePageState();
}

class _BarHomePageState extends State<BarHomePage> {
  final List<String> _listItem = [
    "assets/images/liq1.jpeg",
    "assets/images/liq2.jpeg",
    "assets/images/liq3.jpeg",
    "assets/images/liq4.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 251),
      appBar: AppBar(
        title: const Text("Say Cheers"),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: const BackButton(
          color: Color.fromARGB(255, 251, 240, 240),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  child: ListView(
                    children: [
                      CarouselSlider(
                        items: [
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/drinkoffer1.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/drinkoffer2.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/drinkoffer3.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/drinkoffer4.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/drinkoffer3.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 270.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 800,
                          ),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _listItem
                      .map(
                        (item) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/bar-detail');
                          },
                          child: Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(item),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.bookmark_border,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
