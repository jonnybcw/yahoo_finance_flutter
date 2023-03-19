import 'package:flutter/material.dart';
import 'package:yahoo_finance_flutter/modules/search_stock/search_stock_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({Key? key}) : super(key: key);

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  @override
  Widget build(BuildContext context) {
    return const SearchStockScreen();
  }
}
