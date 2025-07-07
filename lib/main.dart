import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/data/domain/controllers/audio_player_controller.dart';
import 'core/widgets/tabs/base_tab.dart';
import 'features/pages/analytics/analyticspage.dart';
import 'features/pages/search/searchpage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioPlayerController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Color(0xFF1DB954),
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: const BaseTab(),
      routes: <String, WidgetBuilder>{
        '/search': (context) => const SearchPage(),
        '/analytics': (context) => const AnalyticsPage(),
      },
    );
  }
}
