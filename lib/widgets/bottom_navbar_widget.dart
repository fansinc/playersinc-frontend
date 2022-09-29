import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import '/config/app_config.dart';

import '/pages/health_check_page.dart';
import '/pages/challenges_page.dart';
import '/pages/healthy_mind_page.dart';

import '/pages/missions_page.dart';

import '/config/app_strings.dart';

//import '../config/app_config.dart';

import '/pages/home_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int _loadIndex;
  const BottomNavBarWidget(this._loadIndex, {Key? key}) : super(key: key);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget._loadIndex;
  }

  @override
  Widget build(BuildContext context) {
    void _tabPress(int position) {
      if (position == 0) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else if (position == 1) {
        Navigator.of(context).pushReplacementNamed(HealthyMindPage.routeName);
      } else if (position == 2) {
        Navigator.of(context).pushReplacementNamed(ChallengesPage.routeName);
      } else if (position == 3) {
        Navigator.of(context).pushReplacementNamed(MissionsPage.routeName);
      } else if (position == 4) {
        Navigator.of(context).pushReplacementNamed(HealthCheckPage.routeName);
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(AppConfig.blueColor),
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
      ),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      onTap: (indexVal) => _tabPress(indexVal),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: AppStrings.myPlayersInc,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.meditation,
            //Icons.bookmark_border,
          ),
          label: AppStrings.healthyMind,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.checkOutline,
            //Icons.favorite_border,
          ),
          label: AppStrings.challenges,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.task,
          ),
          label: AppStrings.missions,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.medication,
          ),
          label: AppStrings.healthCheck,
        ),
      ],
    );
    // : BottomAppBar());
  }
}
