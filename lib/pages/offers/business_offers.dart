import 'dart:io';
import 'package:app/utils/api_service.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class BusinessOffersPage extends StatefulWidget {
  BusinessOffersPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<BusinessOffersPage> createState() => _BusinessOffersPageState();
}

class _BusinessOffersPageState extends State<BusinessOffersPage> {
  File? image;
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

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

  void onSubmit() async {
    if (widget.formKey.currentState?.validate() == true) {
      if (image != null) {
        const storage = FlutterSecureStorage();
        final authToken = await storage.read(key: token) ?? '';

        await ApiService.instance.requestOffer(
          titleTextController.text,
          descriptionTextController.text,
          image!,
          authToken,
        );

        if (!mounted) return;
        showSnackbar(context, 'Offer Created!');
        Navigator.pop(context);
      } else {
        showSnackbar(context, 'Upload Image!');
      }
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
            Form(
              key: widget.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: titleTextController,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Title is needed';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
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
                          child: const Text("UPLOAD OFFER BANNER (300x200)"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: descriptionTextController,
                      validator: (value) {
                        if (value?.trim().isEmpty == true) {
                          return 'Description is needed';
                        }

                        return null;
                      },
                      maxLines: 5,
                      decoration: const InputDecoration(
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
                ],
              ),
            ),
            const SizedBox(height: 10),
            image != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Image.file(
                      image!,
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
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
                    onPressed: onSubmit,
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
