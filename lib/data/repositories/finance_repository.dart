import 'package:dio/dio.dart';
import 'package:yahoo_finance_flutter/data/api/api_constants.dart';
import 'package:yahoo_finance_flutter/data/api/finance_api.dart';
import 'package:yahoo_finance_flutter/data/models/stock.dart';

class FinanceRepository {
  final Dio _client = ApiConstants.getDioClient();

  Future<Stock> getStockIndicators({
    required String symbol,
  }) async {
    Stock stock = await FinanceApi.getStockIndicators(
      client: _client,
      symbol: symbol,
    );
    return stock;
  }
}
