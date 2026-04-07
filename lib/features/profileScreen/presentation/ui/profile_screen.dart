import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/bloc/profile_bloc.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/profile_header.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/profile_header_skeleton.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/recent_search_skeleton.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/saved_places_skeleton.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/ui/app_alert_dialog.dart';
import 'components/account_managing.dart';
import 'components/profile_saved_places.dart';
import 'components/recent_search.dart';


final List<String> recentSearch = [
  "Italian Restaurant in Nasr City",
  "24h Supermarket",
  "Ladies Gym",
  "Skin Care Clinic",
  "Men's Clothing Shop",
];
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<ProfileBloc>()..add(ProfileScreenStarted()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
          previous.isPostLogout != current.isPostLogout,
          listener: (context, state) {
            if (state.isPostLogout) {
              context.go(MainShellRoute().location);
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {

              if (state.isChecking) {
                return _buildSkeleton();
              }

              if (state.isRegister) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: ProfileHeader()),
                    SliverToBoxAdapter(child: SavedPlaces()),
                    RecentlySearch(recentSearch: recentSearch),
                    SliverToBoxAdapter(child: AccountManagement()),
                  ],
                );
              }

              return Stack(
                children: [
                  _buildSkeleton(),
                  Container(
                    color: AppColors.darkGray.withAlpha(200),
                    child: Center(
                      child: AppAlertDialog(
                        context: context,
                        icon: Icons.security,
                        title: "Login Required",
                        bodyContent:
                        "Please sign in to access your profile settings.",
                        confirmActionTitle: "Sign in",
                        onConfirmPressed: () =>
                            context.go(LoginRoute().location),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: ProfileHeaderSkeleton()),
        SliverToBoxAdapter(child: SavedPlacesSkeleton()),
        const RecentlySearchSkeleton(),
      ],
    );
  }
}