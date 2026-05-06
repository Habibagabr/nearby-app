import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/bloc/profile_bloc.dart';
import 'package:near_buy_gp/shared/components/header_text_style.dart';

import '../common/profile_textfield.dart';

class ProfileEditingPopup extends StatefulWidget {
  const ProfileEditingPopup({super.key});

  @override
  State<ProfileEditingPopup> createState() => _ProfileEditingPopupState();
}

class _ProfileEditingPopupState extends State<ProfileEditingPopup> {
  // Toggle for animation
  bool _isChangingPassword = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.darkGray,
      scrollable: true,
      content: SizedBox(
        width: double.infinity,
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 400),
          crossFadeState: _isChangingPassword
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,

          // --- VIEW 1: EDIT PROFILE ---
          firstChild: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText("Edit Your Profile", textColor: AppColors.white),
              _buildProfileImage(),
              ProfileTextField(textFieldLabel: "User name"),
              ProfileTextField(textFieldLabel: "Email"),
              GestureDetector(
                onTap: () => setState(() => _isChangingPassword = true),
                child: Text(
                  "Change the Password ?",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
          // --- VIEW 2: CHANGE PASSWORD ---
          secondChild: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText("New Password", textColor: AppColors.white),
              ProfileTextField(textFieldLabel: "Current Password"),
              ProfileTextField(textFieldLabel: "New Password"),
              ProfileTextField(textFieldLabel: "Confirm New Password"),
            ],
          ),
        ),
      ),
      actions: [
        if (_isChangingPassword)
          GestureDetector(
            onTap: () => setState(() => _isChangingPassword = false),
            child: Icon(Icons.arrow_back, size: 30, color: AppColors.white),
          ),
        SizedBox(width: 20,),

        ElevatedButton(
          onPressed: () {
            // Add your Save Logic here
            context.read<ProfileBloc>().add(EditProfileCancelled());
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
          child: Text(
            "Save Changes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.darkGray,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ProfileBloc>().add(EditProfileCancelled());
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.darkGray,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 125,
      height: 125,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.person, color: Colors.black, size: 75),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkGray.withAlpha(100),
              ),
              child: const Icon(Icons.edit, color: AppColors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
