import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../features/pages/analytics/analyticspage.dart';
import '../../../features/pages/home/homepage.dart';
import '../../../features/pages/search/searchpage.dart';

class BaseTab extends StatefulWidget {
  const BaseTab({super.key});

  @override
  State<BaseTab> createState() => _BaseTabState();
}

class _BaseTabState extends State<BaseTab> {
  final CupertinoTabController _tabController = CupertinoTabController();

  final Map<String, int> _routeToIndex = {
    '/': 0,
    '/search': 1,
    '/analytics': 2,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context)?.settings.name ?? '/';
      final index = _routeToIndex[route] ?? 0;
      _tabController.index = index;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black,
        activeColor: const Color(0xFF1DB954), // Verde Spotify
        inactiveColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar), label: 'Analytics'),
        ],
        onTap: _onTabChanged,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Padding(padding: EdgeInsetsGeometry.directional(start: 8, end:8), child:HomePage());
          case 1:
            return const Padding(padding: EdgeInsetsGeometry.directional(start: 8, end:8), child:SearchPage());
          case 2:
            return const Padding(padding: EdgeInsetsGeometry.directional(start: 8, end:8), child:AnalyticsPage());
          default:
            return const Center(
              child: Text('Unknown Tab', style: TextStyle(color: Colors.white)),
            );
        }
      },
    );
  }
}
