import 'dart:io';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class BusinessOffersPage extends StatefulWidget {
  const BusinessOffersPage({Key? key}) : super(key: key);

  @override
  State<BusinessOffersPage> createState() => _BusinessOffersPageState();
}

class _BusinessOffersPageState extends State<BusinessOffersPage> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (error) {
      showSnackbar(context, "Failed to pick image: ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Offers",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 9.0,
                    horizontal: 13.0,
                  ),
                  hintText: "Your Offer Title",
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(10, 40),
                      textStyle: const TextStyle(fontSize: 18),
                      primary: Colors.black,
                      side: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () => pickImage(),
                    child: const Text("UPLOAD OFFER BANNER"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 9.0,
                    horizontal: 13.0,
                  ),
                  hintText: "Description",
                ),
              ),
            ),
            const SizedBox(height: 10),
            image != null
                ? Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Image(
                    image: AssetImage('assets/images/whites.jpg'),
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(10, 40),
                      textStyle: const TextStyle(fontSize: 18),
                      primary: Colors.black,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text("SUBMIT"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
