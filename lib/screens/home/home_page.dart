import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:watertracker/screens/history/history_page.dart';
import 'package:watertracker/screens/today/today_page.dart';
import 'package:watertracker/widgets/shadow/shadow_icon.dart';

import 'package:watertracker/screens/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return TodayPage();
      case 1:
        return HistoryPage();
      case 2:
        return SettingsPage();
      default:
        return TodayPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: AlignmentDirectional.topStart,
                  image: AssetImage('assets/background/top-background.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: _getBody(_currentIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Today'), icon: Icon(Icons.home)),
          BottomNavyBarItem(title: Text('History'), icon: Icon(Icons.history)),
          BottomNavyBarItem(
              title: Text('Settings'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

}
