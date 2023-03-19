import 'package:yahoo_finance_flutter/data/models/chart_indicators.dart';
import 'package:yahoo_finance_flutter/data/models/chart_quote.dart';
import 'package:yahoo_finance_flutter/data/models/chart_result.dart';
import 'package:yahoo_finance_flutter/data/models/stock.dart';
import 'package:yahoo_finance_flutter/data/models/stock_chart.dart';
import 'package:yahoo_finance_flutter/data/repositories/finance_repository.dart';

Stock stockInvalidSymbol = const Stock(
  chart: StockChart(
    result: null,
    error: 'Invalid symbol',
  ),
);
Stock stockIndicators = Stock(
  chart: StockChart(
    result: [
      ChartResult(
        timestamp: List.generate(30, (index) => index),
        indicators: ChartIndicators(
          quote: [
            ChartQuote(
              volume: List.generate(30, (index) => index),
              high: List.generate(30, (index) => index * 1.0),
              close: List.generate(30, (index) => index * 1.0),
              open: List.generate(30, (index) => index * 1.0),
              low: List.generate(30, (index) => index * 1.0),
            )
          ],
        ),
      )
    ],
    error: null,
  ),
);

class MockFinanceRepository implements FinanceRepository {
  @override
  Future<Stock> getStockIndicators({required String symbol}) async {
    if (symbol.isEmpty) {
      return stockInvalidSymbol;
    } else {
      return stockIndicators;
    }
  }
}
