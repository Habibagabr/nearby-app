import 'package:flutter/material.dart';

Widget buildCenterMessage(String text, {bool isError = false}) {
  return Center(
    child: Text(
      text,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
