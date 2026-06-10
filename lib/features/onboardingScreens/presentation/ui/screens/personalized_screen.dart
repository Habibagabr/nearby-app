import "package:flutter/material.dart";

import "../../../../../core/themes/app_colors.dart";
import "../../../../../core/themes/app_dimen.dart";
import "../../../../../shared/components/app_logo.dart";
import "../components/personalized_screen_section.dart";
import "../components/user_personalized_option.dart";
import "../models/user_type.dart";

final List<UserOptionModel> interests = [
  UserOptionModel(title: "Food", icon: Icons.restaurant),
  UserOptionModel(title: "Shopping", icon: Icons.shopping_bag_outlined),
  UserOptionModel(title: "Electronics", icon: Icons.devices_outlined),
  UserOptionModel(title: "Fashion", icon: Icons.checkroom_outlined),
  UserOptionModel(title: "Entertainment", icon: Icons.movie_outlined),
  UserOptionModel(title: "Sports", icon: Icons.sports_soccer_outlined),
  UserOptionModel(
    title: "Services",
    icon: Icons.miscellaneous_services_outlined,
  ),
  UserOptionModel(title: "Healthcare", icon: Icons.local_hospital_outlined),
];
final List<UserOptionModel> userTypes = [
  UserOptionModel(title: "Student", icon: Icons.school_outlined),
  UserOptionModel(title: "Employee", icon: Icons.work_outline),
  UserOptionModel(title: "Child", icon: Icons.child_care_outlined),
  UserOptionModel(
    title: "Business Owner",
    icon: Icons.business_center_outlined,
  ),
  UserOptionModel(title: "Parent", icon: Icons.person_outline),
  UserOptionModel(title: "Tourist", icon: Icons.travel_explore_outlined),
  UserOptionModel(title: "Freelancer", icon: Icons.laptop_mac_outlined),
  UserOptionModel(title: "Other", icon: Icons.more_horiz),
];

class PersonalizedScreen extends StatefulWidget {
  const PersonalizedScreen({super.key});

  @override
  State<StatefulWidget> createState() => PersonalizedScreenState();
}

class PersonalizedScreenState extends State<PersonalizedScreen> {
  double selectedAge = 35;
  int userOptionIndex = 0;
  int userInterestIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // TODO: Navigate to login/home
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
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingM),

            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// HEADER
                      Text(
                        "Personalized your Experience",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),

                      /// DESCRIPTION
                      Text(
                        "Help us recommend better places,products, and services around you.",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ///Content
                      /// Age
                      PersonalizedScreenSection(
                        headerTitle: "Your Age",
                        subHeader:
                            "Let us know your age helps us in customize your experience",
                        bodyContent: Padding(
                          padding: EdgeInsetsGeometry.only(top: 22),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "18",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    valueIndicatorTextStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    valueIndicatorColor: Colors.black54,
                                    valueIndicatorShape:
                                        const RectangularSliderValueIndicatorShape(),
                                  ),
                                  child: Slider(
                                    value: selectedAge,
                                    min: 18,
                                    max: 100,
                                    label: selectedAge.toInt().toString(),
                                    thumbColor: AppColors.white,
                                    activeColor: Colors.black54,
                                    inactiveColor: Colors.grey,
                                    showValueIndicator:
                                        ShowValueIndicator.alwaysVisible,
                                    onChanged: (double draggedAge) {
                                      setState(() {
                                        selectedAge = draggedAge;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                "+60",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 50,
                        thickness: 0.5,
                        color: AppColors.white,
                      ),

                      /// How You Are
                      PersonalizedScreenSection(
                        headerTitle: "You Are",
                        subHeader: "Select what describes you best",
                        bodyContent: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              userTypes.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    userOptionIndex = index;
                                  });
                                },
                                child: UserPersonalizedOption(
                                  option: userTypes[index].title,
                                  optionIcon: userTypes[index].icon,
                                  isSelected: userOptionIndex == index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 50,
                        thickness: 0.5,
                        color: AppColors.white,
                      ),

                      /// Your interest
                      PersonalizedScreenSection(
                        headerTitle: "You interset",
                        subHeader: "Select what you're interested in",
                        bodyContent: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              interests.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    userInterestIndex = index;
                                  });
                                },
                                child: UserPersonalizedOption(
                                  option: interests[index].title,
                                  optionIcon: interests[index].icon,
                                  isSelected: userInterestIndex == index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// INDICATOR
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: index == 2 ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == 2
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
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalizedScreen(),
                                ),
                              );
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
                            child: Text("Let's Start"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
