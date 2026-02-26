import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'router/router.dart';

void main() async {
  // Initialize internationalization
  await initializeDateFormatting('ru_RU');
  await initializeDateFormatting('en_US');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Day 31 App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
