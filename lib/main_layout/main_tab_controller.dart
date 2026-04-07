

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainTabController {
  final PersistentTabController tabController = PersistentTabController(
    initialIndex: 0,
  ); //// Home

  void goToHome() {
    tabController.jumpToTab(0);
  }

  void goToDiscovery(){
    tabController.jumpToTab(1);
  }
  // void goToMap(){
  //   tabController.jumpToTab(1);
  // }
  void goToSearch(){
    tabController.jumpToTab(2);
  }
  void goToProfile(){
    tabController.jumpToTab(3);
  }


}
