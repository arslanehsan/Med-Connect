import 'package:url_launcher/url_launcher.dart';

class AppConstents {
  static const String appName = 'Med Connect';
  static const String appVersion = '1.0.0';

  Future<void> launchURL({required String url}) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  void sendMessageOnWhatsApp(String phoneNumber, String message) async {
    String url =
        "https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error: Unable to launch WhatsApp
      print("Error launching WhatsApp");
    }
  }
}
