import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openDialer(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    // Handle error if the dialer cannot be opened
    debugPrint('Could not launch dialer for $phoneNumber');
  }
}
