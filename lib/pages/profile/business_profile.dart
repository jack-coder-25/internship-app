import 'dart:io';
import 'package:app/utils/helper.dart';
import 'package:app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/user.dart';
import 'package:app/styles/buttton.dart';
import 'package:app/utils/authentication_service.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BusinessProfilePage extends StatefulWidget {
  BusinessProfilePage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  State<BusinessProfilePage> createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  late AuthenticationService authService;
  UserObject? user;
  bool isPasswordHidden = true;
  File? aadhar;
  File? pan;
  File? photo;

  var nameTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var alterMobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var brandNameTextController = TextEditingController();
  var landlineTextController = TextEditingController();
  var authSignatureController = TextEditingController();
  var contactPersonController = TextEditingController();
  var addressController = TextEditingController();
  var webLinkController = TextEditingController();
  var bankAccountNameController = TextEditingController();
  var bankAccountNumberController = TextEditingController();
  var bankAccountTypeController = TextEditingController();
  var bankIfscCodeController = TextEditingController();
  var gstNumberController = TextEditingController();
  var gstExemptController = TextEditingController();
  var latLonController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      authService = context.read<AuthenticationService>();

      setState(() {
        user = context.read<UserObject?>();

        nameTextController = TextEditingController(
          text: user?.businessProfile?.data?.name,
        );
        mobileTextController = TextEditingController(
          text: user?.businessProfile?.data?.phone,
        );
        alterMobileTextController = TextEditingController(
          text: user?.businessProfile?.data?.alterPhone,
        );
        emailTextController = TextEditingController(
          text: user?.businessProfile?.data?.email,
        );
        dobTextController = TextEditingController(
          text: user?.businessProfile?.data?.dob,
        );
        brandNameTextController = TextEditingController(
          text: user?.businessProfile?.data?.brandName,
        );
        landlineTextController = TextEditingController(
          text: user?.businessProfile?.data?.landlineNumber,
        );
        authSignatureController = TextEditingController(
          text: user?.businessProfile?.data?.authSign,
        );
        contactPersonController = TextEditingController(
          text: user?.businessProfile?.data?.contactPerson,
        );
        addressController = TextEditingController(
          text: user?.businessProfile?.data?.address,
        );
        webLinkController = TextEditingController(
          text: user?.businessProfile?.data?.weblink,
        );
        bankAccountNameController = TextEditingController(
          text: user?.businessProfile?.data?.bankAccountName,
        );
        bankAccountNumberController = TextEditingController(
          text: user?.businessProfile?.data?.bankAccountNumber,
        );
        bankAccountTypeController = TextEditingController(
          text: user?.businessProfile?.data?.bankAccountType,
        );
        bankIfscCodeController = TextEditingController(
          text: user?.businessProfile?.data?.bankIfsc,
        );
        gstNumberController = TextEditingController(
          text: user?.businessProfile?.data?.gst,
        );
        gstExemptController = TextEditingController(
          text: user?.businessProfile?.data?.gstExept,
        );
        latLonController = TextEditingController(
          text: user?.businessProfile?.data?.lat,
        );
        user = user;
      });
    });
  }

  void togglePasswordView() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  Widget dropDownGst() {
    var items = [
      'We are GST exempted Category',
      'Two',
      'Three',
      'Four',
    ];

    return DropdownButton<String>(
      value: gstExemptController.text.isNotEmpty
          ? gstExemptController.text.trim()
          : null,
      isExpanded: true,
      elevation: 16,
      iconSize: 30.0,
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.amber[50],
      style: const TextStyle(color: Colors.white),
      hint: gstExemptController.text.isEmpty
          ? const Text(
              "Select One",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : Text(
              gstExemptController.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
      onChanged: (String? newValue) {
        setState(() {
          gstExemptController.text = newValue ?? '';
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget merchantDropDown() {
    var items = [
      'One',
      'Two',
      'Free',
      'Four',
    ];

    return DropdownButton<String>(
      value: ''.isNotEmpty ? gstExemptController.text : null,
      isExpanded: true,
      elevation: 16,
      iconSize: 30.0,
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.amber[50],
      style: const TextStyle(color: Colors.white),
      hint: ''.isEmpty
          ? const Text(
              "Select One",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : Text(
              gstExemptController.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
      onChanged: (String? newValue) {
        setState(() {});
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget bankAccountType() {
    var items = [
      'One',
      'Two',
      'Free',
      'Four',
    ];

    return DropdownButton<String>(
      value: bankAccountTypeController.text.isNotEmpty
          ? bankAccountTypeController.text
          : null,
      isExpanded: true,
      elevation: 10,
      iconSize: 30.0,
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      hint: bankAccountTypeController.text.isEmpty
          ? const Text(
              "Select One",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : Text(
              bankAccountTypeController.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
      onChanged: (String? newValue) {
        setState(() {
          bankAccountTypeController.text = newValue ?? '';
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<void> onSubmit() async {
    if (widget.formKey.currentState?.validate() == true) {
      try {
        await authService.updateProfile(
          name: nameTextController.text,
          password: passwordTextController.text,
          mobile: mobileTextController.text,
          alterMobile: alterMobileTextController.text,
          email: emailTextController.text,
          dob: dobTextController.text,
          landline: landlineTextController.text,
          authSignature: authSignatureController.text,
          contactPerson: contactPersonController.text,
          address: addressController.text,
          webLink: webLinkController.text,
          bankAccountName: bankAccountNameController.text,
          bankAccountNumber: bankAccountNumberController.text,
          bankAccountType: bankAccountTypeController.text,
          bankIfscCode: bankIfscCodeController.text,
          gstNumber: gstNumberController.text,
          gstExempt: gstExemptController.text,
          latLon: latLonController.text,
          aadhar: aadhar,
          pan: pan,
          photo: photo,
        );
        if (!mounted) return;
        showSnackbar(context, 'Profile Updated');
      } catch (error) {
        showSnackbar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.red,
      appBar: AppBar(
        title: const Text('My Business Account'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorConstants.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: validateFullName,
                      controller: nameTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateAddress,
                      controller: addressController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Business Address',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateAddress,
                      controller: authSignatureController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Authorized Signature name',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateContactPerson,
                      controller: contactPersonController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Contact Person',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: validateMobile,
                      controller: mobileTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        prefixText: "+91",
                        hintText: 'Phone',
                        counterStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: validateMobile,
                      controller: alterMobileTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Alternate Mobile Number',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: validateEmail,
                      controller: emailTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('GST No.'),
                      controller: gstNumberController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'GST No.',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    dropDownGst(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onTap: () async {
                        try {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          setState(() => aadhar = imageTemporary);
                        } on PlatformException catch (error) {
                          showSnackbar(
                            context,
                            "Failed to pick image: ${error.toString()}",
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Aadhar card Upload',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onTap: () async {
                        try {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          setState(() => aadhar = imageTemporary);
                        } on PlatformException catch (error) {
                          showSnackbar(
                            context,
                            "Failed to pick image: ${error.toString()}",
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Pan card Upload',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('Weblink'),
                      controller: webLinkController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Weblink',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                        // suffixIcon: Row(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('Lat, Lon'),
                      controller: latLonController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Latitude, Longitude',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    merchantDropDown(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Bank Details',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('Bank Account Name'),
                      controller: bankAccountNameController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Bank Account Name',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                        // suffixIcon: Row(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    bankAccountType(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('Bank Account Number'),
                      controller: bankAccountNumberController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Bank Account Number',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                        // suffixIcon: Row(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: validateNotEmpty('IFSC Code'),
                      controller: bankIfscCodeController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'IFSC Code',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      controller: passwordTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: togglePasswordView,
                        ),
                        // suffixIcon: Row(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      controller: confirmPasswordTextController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: togglePasswordView,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onTap: () async {
                        try {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          setState(() => photo = imageTemporary);
                        } on PlatformException catch (error) {
                          showSnackbar(
                            context,
                            "Failed to pick image: ${error.toString()}",
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.business),
                        hintText: 'Shop Photo Upload',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white70,
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: onSubmit,
                      style: buttonStyleRed,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: ColorConstants.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
