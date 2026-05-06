import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  final String textFieldLabel;

  const ProfileTextField({super.key , required this.textFieldLabel});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  // 1. Create a FocusNode to track the focus state
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // 2. Add a listener to update the UI when focus changes
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      // 3. Use a conditional color for the text style
      style: TextStyle(
        color: _isFocused ? Colors.white : Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: widget.textFieldLabel,
        labelStyle:  TextStyle(color: _isFocused ? Colors.white : Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
    );
  }
}
