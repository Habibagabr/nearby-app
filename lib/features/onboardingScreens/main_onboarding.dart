import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/features/onboardingScreens/presentation/bloc/onboarding_bloc.dart';
import 'package:near_buy_gp/features/onboardingScreens/presentation/ui/components/ar_location_card.dart';
import 'package:near_buy_gp/features/onboardingScreens/presentation/ui/components/search_sample.dart';
import 'package:near_buy_gp/features/onboardingScreens/presentation/ui/models/onboarding_model.dart';
import 'package:near_buy_gp/features/onboardingScreens/presentation/ui/screens/personalized_screen.dart';
import 'package:near_buy_gp/shared/components/app_logo.dart';

import '../../core/di/injection.dart';
import '../../core/routing/app_routes.dart';

List<OnboardingModel> onboardingScreensData = [
  OnboardingModel(
    screenHeader: "Welcome to NearBuy",
    screenSubHeader: "Find Anything Nearby, Naturally",
    screenDescription:
        "Search the way you speak , Find products, stores, services, or any place around you. See inventory, check availability and explore everything nearby.",
    bodyContent: SizedBox(
      width: double.infinity,
      height: 420,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Positioned(
            left: -40,
            child: SizedBox(
              width: 300,

              child: Image.asset(
                "assets/images/onboardone.webp",
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            right: -10,
            top: 90,
            child: SizedBox(
              width: 230,
              child: Column(
                children: [
                  SearchSample(
                    query: "Where can I buy a laptop?",
                    result: "3 nearby stores found",
                  ),

                  const SizedBox(height: 18),

                  SearchSample(
                    query: "Best pharmacy near me",
                    result: "5 nearby results",
                  ),

                  const SizedBox(height: 18),

                  SearchSample(
                    query: "Nike shoes",
                    result: "Available in 4 stores",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    onNextClicked: () {},
    onBackClicked: () {},
  ),
  OnboardingModel(
    screenHeader: "Smart AR Discovery",
    screenSubHeader: "See What's Around You",
    screenDescription:
        "Turn on AR Mode and instantly discover nearby stores, products, and services through your camera.",
    bodyContent: SizedBox(
      width: double.infinity,
      height: 600,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Positioned(
            left: -5,
            child: SizedBox(
              width: 300,

              child: Image.asset(
                "assets/images/onboardtwo.webp",
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            right: -5,
            top: 90,
            child: SizedBox(
              width: 230,
              child: Column(
                children: [
                  ArLocationCard(
                    icon: Icons.hotel,
                    title: "Hotel",
                    rating: 4,
                    distance: "40m",
                    iconColor: Colors.deepPurpleAccent,
                  ),

                  SizedBox(height: 20),

                  ArLocationCard(
                    icon: Icons.local_grocery_store,
                    title: "Grocery Store",
                    rating: 4,
                    distance: "30m",
                    iconColor: Colors.orange,
                  ),

                  SizedBox(height: 20),

                  ArLocationCard(
                    icon: Icons.restaurant,
                    title: "Restaurant",
                    rating: 5,
                    distance: "25m",
                    iconColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    onNextClicked: () {},
    onBackClicked: () {},
  ),
];

class MainOnboarding extends StatefulWidget {
  const MainOnboarding({super.key});

  @override
  State<MainOnboarding> createState() => _MainOnboardingState();
}

class _MainOnboardingState extends State<MainOnboarding> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingBloc>(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is NavigateToHome) {
            // Safe clean route transition to Home Screen shell
            context.go(MainShellRoute().location);
          }
          if (state is OnboardingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leadingWidth: 160,
            leading: AppLogo(AppColors.white),
            actionsPadding: EdgeInsetsGeometry.directional(end: 18),
            actions: [
              GestureDetector(
                onTap: () {
                  context.read<OnboardingBloc>().add(SkipPressed());
                },
                child: const Center(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: Container(
            width: double.infinity,
            height: double.infinity,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/mapbackground.webp"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.darkGray.withOpacity(.90),
                  BlendMode.srcOver,
                ),
              ),
            ),

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingM,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const SizedBox(height: 16),

                    /// HEADER
                    Text(
                      onboardingScreensData[screenIndex].screenHeader,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    if (onboardingScreensData[screenIndex].screenSubHeader !=
                        null)
                      const SizedBox(height: 8),

                    Text(
                      onboardingScreensData[screenIndex].screenSubHeader ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),

                    SizedBox(
                      height:
                          onboardingScreensData[screenIndex].screenSubHeader !=
                              null
                          ? 20
                          : 5,
                    ),

                    /// DESCRIPTION
                    Text(
                      onboardingScreensData[screenIndex].screenDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// IMAGE AREA
                    Expanded(
                      child: onboardingScreensData[screenIndex].bodyContent,
                    ),

                    /// INDICATOR
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingScreensData.length + 1,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: screenIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: screenIndex == index
                                ? AppColors.orange
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// NAVIGATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (screenIndex != 0)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                screenIndex--;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          )
                        else
                          SizedBox(width: 100),

                        ElevatedButton(
                          onPressed: () {
                            if (screenIndex <
                                onboardingScreensData.length - 1) {
                              setState(() {
                                screenIndex++;
                              });
                            } else {
                              /// FIX ME
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                      ) => const PersonalizedScreen(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange.withAlpha(200),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: Text("Next"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
