import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:yahoo_finance_flutter/data/api/api_constants.dart';
import 'package:yahoo_finance_flutter/data/models/stock.dart';

class FinanceApi {
  static Future<Stock> getStockIndicators({
    required Dio client,
    required String symbol,
  }) async {
    try {
      final Response response = await client.get(ApiConstants.chart(symbol));
      Stock stock = Stock.fromJson(response.data);
      return stock;
    } catch (error, stacktrace) {
      log('$error',
          name: 'getStockIndicators', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
