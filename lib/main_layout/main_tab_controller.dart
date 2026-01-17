

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainTabController {
  final PersistentTabController tabController = PersistentTabController(
    initialIndex: 2,
  ); // Home

  void goToDiscovery(){
    tabController.jumpToTab(0);
  }
  void goToMap(){
    tabController.jumpToTab(1);
  }
  void goToHome() {
    tabController.jumpToTab(2);
  }
  void goToSearch(){
    tabController.jumpToTab(3);
  }
  void goToProfile(){
    tabController.jumpToTab(4);
  }


}
