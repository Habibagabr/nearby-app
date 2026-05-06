// import 'package:flutter/material.dart';
// import 'package:flutter_embed_unity/flutter_embed_unity.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             // This will render your Unity project
//             child: EmbedUnity(
//               onMessageFromUnity: (String message) {
//                 // Receive message from Unity scripts here
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Send message to Unity
//               sendToUnity(
//                 "MyGameObject",  // Game object name
//                 "SetRotationSpeed",  // Unity script function name
//                 "42",  // Message
//               );
//             },
//             child: const Text("Set rotation speed"),
//           )
//         ],
//       ),
//     ),
//   ));
// }