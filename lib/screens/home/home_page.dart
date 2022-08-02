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
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoTabScaffold(
  //     tabBar: CupertinoTabBar(
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //             icon: ShadowIcon(
  //               Icons.home,
  //               offsetX: 0.0,
  //               offsetY: 0.0,
  //               blur: 3.0,
  //               shadowColor: Colors.black.withOpacity(0.25),
  //             ),
  //             label: 'Today'),
  //         BottomNavigationBarItem(
  //             icon: ShadowIcon(
  //               Icons.history,
  //               offsetX: 0.0,
  //               offsetY: 0.0,
  //               blur: 3.0,
  //               shadowColor: Colors.black.withOpacity(0.25),
  //             ),
  //             label:'History'),
  //
  //         BottomNavigationBarItem(
  //             icon: ShadowIcon(
  //               Icons.settings,
  //               offsetX: 0.0,
  //               offsetY: 0.0,
  //               blur: 3.0,
  //               shadowColor: Colors.black.withOpacity(0.25),
  //             ),
  //             label: 'Settings'),
  //       ],
  //       backgroundColor: Colors.white,
  //       iconSize: 28.0,
  //       activeColor: const Color(0xFF4c9bfb),
  //       inactiveColor: const Color(0xFFa3a3a3),
  //     ),
  //     tabBuilder: (BuildContext context, int index) {
  //       return CupertinoTabView(
  //         builder: (BuildContext context) {
  //           return CupertinoPageScaffold(
  //               backgroundColor: const Color(0xFFf7f7f7),
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             alignment: AlignmentDirectional.topStart,
  //                             image: AssetImage(
  //                                 'assets/background/top-background.png'),
  //                             fit: BoxFit.fitWidth)),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(top: 40),
  //                     child: _getBody(index),
  //                   ),
  //                 ],
  //               ));
  //         },
  //       );
  //     },
  //   );
  // }
}
