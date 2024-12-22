import 'dart:io';

Future<bool> isInternetAvailable() async {
  try {
    // Try to connect to a reliable server (Google DNS in this case).
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true; // Internet is available
    }
  } catch (e) {
    // Exception indicates no internet
    return false;
  }
  return false;
}
