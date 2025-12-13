import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import '../utils/auth_field_type.dart';

class InputField extends StatefulWidget {
  final AuthFieldType inputType;
  final String label;
  final String hint;
  final bool isError;
  final String? errorMessage;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.inputType,
    required this.label,
    required this.hint,
    this.isError = false,
    this.errorMessage,
    this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscured = true;

  bool get _isPasswordField =>
      widget.inputType == AuthFieldType.password ||
          widget.inputType == AuthFieldType.confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Text(
          widget.label,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.darkGray,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        /// TextField
        TextField(
          controller: widget.controller,
          obscureText: _isPasswordField ? _isObscured : false,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.white.withValues(alpha: 0.5),
            ),

            ///  Eye icon
            suffixIcon: _isPasswordField
                ? IconButton(
              icon: Icon(
                _isObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.white,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            )
                : null,
          ),
        ),

        /// Error message
        if (widget.isError) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorMessage ?? '',
            style: AppTextStyles.errorText,
          ),
        ],
      ],
    );
  }
}
