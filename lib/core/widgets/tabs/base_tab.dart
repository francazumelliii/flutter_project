import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project/features/pages/home/homepage.dart';
import 'package:flutter_project/features/pages/search/searchpage.dart';
import 'package:flutter_project/features/pages/analytics/analyticspage.dart';

class BaseTab extends StatefulWidget {
  const BaseTab({super.key});

  @override
  State<BaseTab> createState() => _BaseTabState();
}

class _BaseTabState extends State<BaseTab> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget getPage(int index) {
    if (index == 0) return const HomePage();
    if (index == 1) return const SearchPage();
    if (index == 2) return const AnalyticsPage();
    return const Center(child: Text('Pagina non trovata', style: TextStyle(color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        activeColor: const Color(0xFF1DB954),
        inactiveColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Cerca'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar), label: 'Analytics'),
        ],
        onTap: onTabTapped,
        currentIndex: currentIndex,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => getPage(index),
        );
      },
    );
  }
}
