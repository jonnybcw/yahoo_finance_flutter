part of 'stock_variation_bloc.dart';

abstract class StockVariationState extends Equatable {
  const StockVariationState();

  @override
  List<Object?> get props => [];
}

class StockVariationInitial extends StockVariationState {}

class StockVariationResult extends StockVariationState {
  const StockVariationResult({
    required this.chartResult,
    required this.stockVariation,
  });

  final ChartResult chartResult;
  final List<StockVariation> stockVariation;

  @override
  List<Object?> get props => [
        chartResult,
        stockVariation,
      ];
}

class StockVariationFailure extends StockVariationState {}
