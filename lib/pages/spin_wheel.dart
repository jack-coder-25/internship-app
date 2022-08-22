import 'package:app/constants/colors.dart';
import 'package:app/styles/buttton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({Key? key}) : super(key: key);

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List<int> items = [100, 200, 500, 1000, 2000];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lucky draw"),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: const BackButton(
          color: Color.fromARGB(255, 251, 240, 240),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/luck.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                      FortuneItem(child: Text(items[i].toString())),
                    },
                  ],
                  onAnimationEnd: () {
                    setState(() {
                      rewards = items[selected.value];
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You just won $rewards Points!"),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: buttonStyleRed,
                onPressed: () {
                  setState(() {
                    selected.add(Fortune.randomInt(0, items.length));
                  });
                },
                child: const Text(
                  "SPIN",
                  style: TextStyle(color: ColorConstants.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
