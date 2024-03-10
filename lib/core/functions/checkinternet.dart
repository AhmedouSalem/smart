import 'dart:io';

Future<bool> checkInternet() async {
  try {
    List<InternetAddress> internetAddress = await InternetAddress.lookup(
        "google.com",
        type: InternetAddressType.any);
    if (internetAddress.isNotEmpty &&
        internetAddress[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}
