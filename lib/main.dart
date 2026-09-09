import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'views/dashboard_view.dart';

void main() {
  runApp(const CampFutApp());
}

class CampFutApp extends StatelessWidget {
  const CampFutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campfut',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardView(),
    );
  }
}