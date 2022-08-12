import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class PartnersPage extends StatefulWidget {
  const PartnersPage({Key? key}) : super(key: key);

  @override
  State<PartnersPage> createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
  final List<String> _listItem = [
    "assets/images/the-park-hotels.png",
    "assets/images/benze.png",
    "assets/images/itc-hotel.jpg",
    "assets/images/leela-palace.png",
    "assets/images/zodiac.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 251),
      appBar: AppBar(
        title: const Text("Our Partners"),
        backgroundColor: ColorConstants.red,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
    );
  }
}
