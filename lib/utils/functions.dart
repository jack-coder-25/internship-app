import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHiJjKkLlMmNnOoPpQqRrSsTtUuvWwXxYyZz14567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
