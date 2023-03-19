import 'package:flutter/material.dart';
import 'package:yahoo_finance_flutter/config/repositories.dart';
import 'package:yahoo_finance_flutter/modules/core/core_screen.dart';

void main() {
  Repositories.register();
  runApp(const YahooFinanceApp());
}

class YahooFinanceApp extends StatelessWidget {
  const YahooFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahoo Finance',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const CoreScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
