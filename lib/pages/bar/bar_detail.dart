import 'package:app/constants/colors.dart';
import 'package:app/styles/buttton.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

class BarDetailPage extends StatefulWidget {
  const BarDetailPage({Key? key}) : super(key: key);

  @override
  State<BarDetailPage> createState() => _BarDetailPageState();
}

class _BarDetailPageState extends State<BarDetailPage> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 120.0),
        SizedBox(height: 10.0),
        Text(
          "Jack Daniel's",
          style: TextStyle(
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        SizedBox(height: 30.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/liq1.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(150, 25, 25, 25),
          ),
          child: Center(
            child: topContentText,
          ),
        )
      ],
    );

    final buyButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          QuantityInput(
            value: quantity,
            onChanged: (value) => setState(
              () => quantity = int.parse(value.replaceAll(',', '')),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          ElevatedButton(
            onPressed: () => {},
            style: buttonStyle,
            child: const Text(
              "BUY NOW",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    const bottomText = Text(
      "Jack Daniel's is a brand of Tennessee whiskey. It is produced in Lynchburg, Tennessee, by the Jack Daniel Distillery, which has been owned by the Brown–Forman Corporation since 1956.",
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomText, buyButton],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drink"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Icon(Icons.shopping_cart),
                Padding(padding: EdgeInsets.all(4.0)),
                Text("58"),
              ],
            ),
          )
        ],
        backgroundColor: ColorConstants.red,
      ),
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
