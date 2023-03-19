import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:yahoo_finance_flutter/data/models/chart_quote.dart';
import 'package:yahoo_finance_flutter/data/models/chart_result.dart';
import 'package:yahoo_finance_flutter/data/models/stock_variation.dart';

part 'stock_variation_event.dart';
part 'stock_variation_state.dart';

class StockVariationBloc
    extends Bloc<StockVariationEvent, StockVariationState> {
  StockVariationBloc({
    required this.chartResult,
  }) : super(StockVariationInitial()) {
    on<VariationCalculated>((event, emit) {
      emit(StockVariationResult(
        chartResult: chartResult,
        stockVariation: _stockVariation,
      ));
    });
    on<CalculationFailed>((event, emit) {
      emit(StockVariationFailure());
    });
    on<RetryButtonTapped>((event, emit) {
      emit(StockVariationInitial());
      _calculatePriceVariation();
    });

    _calculatePriceVariation();
  }

  final ChartResult chartResult;
  final List<StockVariation> _stockVariation = [];

  void _calculatePriceVariation() {
    int length = chartResult.timestamp?.length ?? 0;
    if (length > 30) {
      length = 30;
    }

    List<int>? timestamps = chartResult.timestamp
        ?.sublist((chartResult.timestamp?.length ?? 0) - length);

    if (timestamps == null) {
      add(CalculationFailed());
      return;
    }

    ChartQuote? quote = chartResult.indicators.quote.firstOrNull;
    if (quote == null) {
      add(CalculationFailed());
      return;
    }
    List<double?> prices = quote.open.sublist(quote.open.length - length);

    int index = 0;
    double? first = prices[0];
    for (double? price in prices) {
      double? variationD1;
      double? variationFirstDate;
      if (index == 0) {
        variationD1 = 0;
        variationFirstDate = 0;
      } else {
        double? last = prices[index - 1];
        if (last != null && price != null) {
          variationD1 = ((price * 100) / last) - 100;
        } else {
          variationD1 = null;
        }

        if (first != null && price != null) {
          variationFirstDate = ((price * 100) / first) - 100;
        } else {
          variationFirstDate = null;
        }
      }

      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(timestamps[index] * 1000);

      _stockVariation.add(
        StockVariation(
          date: date,
          price: price,
          variationD1: variationD1,
          variationFirstDate: variationFirstDate,
        ),
      );

      index++;
    }

    add(VariationCalculated());
  }
}
