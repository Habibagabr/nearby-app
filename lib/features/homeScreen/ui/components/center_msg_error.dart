import 'package:flutter/material.dart';


// FIXME : THIS IS WILL BE REMOVED AS WE USING THE ERROR WIDGET NOW
Widget buildCenterMessage(
    String text, {
      bool isError = false,
      String? imageUrl,
    }) {
  return Stack(
    children: [

      /// 🔹 Background Image fills full screen
      if (imageUrl != null)
        Positioned.fill(
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),

      /// 🔹 Dark overlay for readability
      if (imageUrl != null)
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.45),
          ),
        ),

      /// 🔹 Centered Message
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isError ? Colors.red : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  );
}