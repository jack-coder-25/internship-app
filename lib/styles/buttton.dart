import 'package:flutter/material.dart';
import 'package:mci/constants/colors.dart';

ButtonStyle buttonStyle = TextButton.styleFrom(
  backgroundColor: ColorConstants.red,
  fixedSize: const Size(160, 36),
  padding: const EdgeInsets.symmetric(horizontal: 18.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
);

final ButtonStyle buttonStyleRed = TextButton.styleFrom(
  backgroundColor: Colors.white,
  fixedSize: const Size(160, 36),
  padding: const EdgeInsets.symmetric(horizontal: 18.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
);
