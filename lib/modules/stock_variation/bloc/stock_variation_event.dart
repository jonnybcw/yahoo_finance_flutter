part of 'stock_variation_bloc.dart';

abstract class StockVariationEvent extends Equatable {
  const StockVariationEvent();

  @override
  List<Object?> get props => [];
}

class VariationCalculated extends StockVariationEvent {}

class CalculationFailed extends StockVariationEvent {}

class RetryButtonTapped extends StockVariationEvent {}
