import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/helper.dart';
import 'package:mci/utils/validation.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final nameTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  UserObject? user;

  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: 'LXb3EKWsInQ',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = context.read<UserObject?>();
      setState(() {});
    });
  }

  void onSubmit() async {
    try {
      await ApiService.instance.sendSupportQuery(
        nameTextController.text,
        mobileTextController.text,
        emailTextController.text,
        descriptionTextController.text,
        user!.accountType,
      );
      if (!mounted) return;
      showSnackbar(context, 'Support Query Submitted!');
    } catch (error) {
      showSnackbar(context, 'Something went wrong!');
    } finally {
      nameTextController.text = '';
      mobileTextController.text = '';
      emailTextController.text = '';
      descriptionTextController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                controller: nameTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  labelText: 'Full Name',
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
                controller: mobileTextController,
                decoration: InputDecoration(
                  prefixText: "+91",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  labelText: 'Mobile no.',
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
                controller: emailTextController,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  labelText: 'Email',
                  hintText: 'mail@domain.com',
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
              SizedBox(
                child: TextFormField(
                  controller: descriptionTextController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    labelText: 'Description',
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
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              Center(
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: onSubmit,
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Contact Us",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Phone",
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "+919790985285",
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Email",
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "customercare@bvcindia.com",
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Address",
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "No 781, Rayala Towers, 2nd Floor, \n Anna Salai, Mount Road, Chennai - 600002 \n (Opposite Rageja Towers & LIC Building)",
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
