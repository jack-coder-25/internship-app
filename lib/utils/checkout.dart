import 'package:flutter/services.dart';

MethodChannel channel = const MethodChannel('ease_buzz');

Future<dynamic> makePayment(String accessKey) async {
  String payMode = "test"; // Change to "production" if releasing

  Object parameters = {
    "access_key": accessKey,
    "pay_mode": payMode,
  };

  final paymentResponse = await channel.invokeMethod(
    "payWithEasebuzz",
    parameters,
  );

  return paymentResponse;
}
