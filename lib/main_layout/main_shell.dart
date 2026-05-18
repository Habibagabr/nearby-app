import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/main_layout/main_tab_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../features/discoveryScreen/presentation/discovery_screen.dart';
import '../features/homeScreen/ui/home_screen.dart';
import '../features/mapScreen/presentation/map_screen.dart';
import '../features/profileScreen/presentation/ui/profile_screen.dart';
import '../features/searchScreen/presentation/search_screen.dart';



class MainShell extends StatelessWidget {
  MainShell({super.key});

  final PersistentTabController _controller = MainTabController().tabController;


  List<Widget> _screens() {
    return const [
      HomeScreen(),
      DiscoveryScreen(),
      // MapScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _items() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColors.white,
        activeColorSecondary: AppColors.darkGray,
        inactiveColorPrimary: AppColors.white,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.explore),
        title: "Discover",
        activeColorPrimary: AppColors.white,
        activeColorSecondary: AppColors.darkGray,
        inactiveColorPrimary: AppColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "Search",
        activeColorPrimary: AppColors.white,
        activeColorSecondary: AppColors.darkGray,
        inactiveColorPrimary:AppColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.white,
        activeColorSecondary: AppColors.darkGray,
        inactiveColorPrimary: AppColors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style10,
      confineToSafeArea: true,
      backgroundColor: AppColors.darkGray,

      stateManagement: true,
      resizeToAvoidBottomInset: true,


    );
  }
}
