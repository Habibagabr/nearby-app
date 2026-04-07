import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String link) async {
  final Uri url = Uri.parse(link);

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    debugPrint('Could not launch $link');
  }
}