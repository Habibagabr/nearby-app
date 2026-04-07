import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/bloc/profile_bloc.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/ui/popup_component.dart';
import '../../../../../shared/components/header_text_style.dart';
import '../common/data_card.dart';

class AccountManagement extends StatelessWidget {
  const AccountManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          HeaderText("Account", textColor: AppColors.darkGray),
          SizedBox(height: 20),
          DataCard(
            cardSubTitle: "App Preference",
            cardTitle: "Settings",
            icon: Icons.settings,
            topRight: 24,
            topLeft: 24,
          ),
          DataCard(
            cardSubTitle: "manage your data",
            cardTitle: "Privacy & Security",
            icon: Icons.privacy_tip,
          ),
          DataCard(
            cardSubTitle: "Sign out from your Account",
            cardTitle: "Logout",
            icon: Icons.login_rounded,
            iconColor: Colors.red,
            iconBackgroundColor: Colors.redAccent.withAlpha(50),
            titleColor: Colors.red,
            bottomLeft: 24,
            bottomRight: 24,
            onCardClicked: () {
              // Store the bloc reference BEFORE opening the popup
              final profileBloc = context.read<ProfileBloc>();

              appPopup(
                context: context,
                icon: Icons.logout,
                title: "Logout",
                bodyContent: "Are you sure you want to sign out?",
                confirmActionTitle: "Logout",
                dismissActionTitle: "Cancel",
                onConfirmPressed: () async {
                  // 1. Trigger the event using the stored reference
                  profileBloc.add(LogoutConfirmed());
                }
              );
            },
          ),
        ],
      ),
    );
  }
}
