import 'package:mci/constants/constants.dart';
import 'package:mci/styles/buttton.dart';
import 'package:mci/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/models/user.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mci/utils/validation.dart';

class MemberProfilePage extends StatefulWidget {
  MemberProfilePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  late AuthenticationService authService;
  UserObject? user;

  var nameTextController = TextEditingController();
  var fatherNameTextController = TextEditingController();
  var motherNameTextController = TextEditingController();
  var occupationTextController = TextEditingController();
  var marriedTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var weddingDateTextController = TextEditingController();
  var spouseNameTextController = TextEditingController();
  var spouseDobTextController = TextEditingController();
  var numberOfChildTextController = TextEditingController();
  var doorNumberTextController = TextEditingController();
  var buildingNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var cityTextController = TextEditingController();
  var stateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      authService = context.read<AuthenticationService>();

      setState(() {
        user = context.read<UserObject?>();

        nameTextController = TextEditingController(
          text: user?.profile?.data?.name,
        );
        mobileTextController = TextEditingController(
          text: user?.profile?.data?.phone,
        );
        emailTextController = TextEditingController(
          text: user?.profile?.data?.email,
        );
        dobTextController = TextEditingController(
          text: user?.profile?.data?.dob,
        );
        fatherNameTextController = TextEditingController(
          text: user?.profile?.data?.fatherName,
        );
        motherNameTextController = TextEditingController(
          text: user?.profile?.data?.motherName,
        );
        occupationTextController = TextEditingController(
          text: user?.profile?.data?.occupation,
        );
        marriedTextController = TextEditingController(
          text: user?.profile?.data?.maritalStatus,
        );
        weddingDateTextController = TextEditingController(
          text: user?.profile?.data?.weddingDate,
        );
        spouseNameTextController = TextEditingController(
          text: user?.profile?.data?.spouseName,
        );
        spouseDobTextController = TextEditingController(
          text: user?.profile?.data?.spouseDob,
        );
        numberOfChildTextController = TextEditingController(
          text: user?.profile?.data?.childrens,
        );
        doorNumberTextController = TextEditingController(
          text: user?.profile?.data?.doorNo,
        );
        buildingNameTextController = TextEditingController(
          text: user?.profile?.data?.buildingName,
        );
        addressTextController = TextEditingController(
          text: user?.profile?.data?.address,
        );
        cityTextController = TextEditingController(
          text: user?.profile?.data?.city,
        );
        stateTextController = TextEditingController(
          text: user?.profile?.data?.state,
        );
      });
    });
  }

  Future<DateTime?> showDatePickerDialog() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<void> onSubmit() async {
    try {
      await authService.updateProfile(
        name: nameTextController.text,
        fatherName: fatherNameTextController.text,
        motherName: motherNameTextController.text,
        occupation: occupationTextController.text,
        married: marriedTextController.text,
        mobile: mobileTextController.text,
        email: emailTextController.text,
        dob: dobTextController.text,
        weddingDate: weddingDateTextController.text,
        spouseName: spouseNameTextController.text,
        spouseDob: spouseDobTextController.text,
        numberOfChild: numberOfChildTextController.text,
        doorNumber: doorNumberTextController.text,
        buildingName: buildingNameTextController.text,
        address: addressTextController.text,
        city: cityTextController.text,
        state: stateTextController.text,
      );
      if (!mounted) return;
      showSnackbar(context, 'Profile Updated');
    } catch (error) {
      showSnackbar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        backgroundColor: ColorConstants.red,
        leading: BackButton(
          color: const Color.fromARGB(255, 251, 240, 240),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: user?.profile?.data?.subscriptionId == null
                      ? InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/subscription');
                          },
                          child: Card(
                            color: Colors.black,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'No Subscription Plan Active',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Card(
                          color: Colors.grey,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                  '${ApiConstants.uploadsPath}/${(user!.profile?.data!.subscription!.cardBg!)}',
                                ),
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop,
                                ),
                                height: 180,
                                fit: BoxFit.fill,
                                child: InkWell(
                                  onTap: () {},
                                ),
                              ),
                              Text(
                                user?.profile?.data?.subscription?.title ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(212, 255, 253, 253),
                                  fontSize: 24,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(10.0, 10.0),
                                      blurRadius: 8.0,
                                      color: Color.fromARGB(255, 72, 33, 33),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: widget._formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateFullName,
                        keyboardType: TextInputType.name,
                        controller: nameTextController,
                        textCapitalization: TextCapitalization.words,
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
                        validator: validateDateOfBirth,
                        controller: dobTextController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                          labelText: "Date Of Birth",
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
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePickerDialog();

                          if (pickedDate != null) {
                            dobTextController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validateMobile,
                        controller: mobileTextController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixText: "+91",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Mobile',
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
                        validator: validateEmail,
                        controller: emailTextController,
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
                      TextFormField(
                        validator: validateNotEmpty('Occupation'),
                        controller: occupationTextController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Occupation',
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
                        validator: validateNotEmpty('Father Name'),
                        controller: fatherNameTextController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Father Name',
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
                        validator: validateNotEmpty('Mother Name'),
                        controller: motherNameTextController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Mother Name',
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
                      Row(
                        children: [
                          Radio(
                            value: "Married",
                            groupValue: marriedTextController.text,
                            onChanged: (value) {
                              setState(() {
                                marriedTextController.text = value.toString();
                              });
                            },
                            activeColor: ColorConstants.red,
                            fillColor: MaterialStateProperty.all(
                              ColorConstants.red,
                            ),
                          ),
                          const Text(
                            "Married",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 1, 1, 1),
                            ),
                          ),
                          Radio(
                            value: "Unmarried",
                            groupValue: marriedTextController.text,
                            onChanged: (value) {
                              setState(() {
                                marriedTextController.text = value.toString();
                              });
                            },
                            activeColor: ColorConstants.red,
                            fillColor: MaterialStateProperty.all(
                              ColorConstants.red,
                            ),
                          ),
                          const Text(
                            "Unmarried",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 1, 1, 1),
                            ),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validateDateOfBirth,
                        controller: weddingDateTextController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                          labelText: "Wedding Date",
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
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePickerDialog();

                          if (pickedDate != null) {
                            weddingDateTextController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validateFullName,
                        controller: spouseNameTextController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Spouse Name',
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
                        validator: validateDateOfBirth,
                        controller: spouseDobTextController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                          labelText: "Spouse Date Of Birth",
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
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePickerDialog();

                          if (pickedDate != null) {
                            spouseDobTextController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          }
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      TextFormField(
                        validator: validateNotEmpty('No. Of Childrens'),
                        controller: numberOfChildTextController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'No. of Childrens',
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
                        validator: validateNotEmpty('Door No,'),
                        controller: doorNumberTextController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Door No.',
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
                        validator: validateNotEmpty('Building Name'),
                        controller: buildingNameTextController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Building Name',
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
                        validator: validateNotEmpty('Address'),
                        controller: addressTextController,
                        keyboardType: TextInputType.streetAddress,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'Address',
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
                        validator: validateNotEmpty('City'),
                        controller: cityTextController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'City',
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
                        validator: validateNotEmpty('State'),
                        controller: stateTextController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          labelText: 'State',
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
                      ElevatedButton(
                        onPressed: onSubmit,
                        style: buttonStyle,
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
