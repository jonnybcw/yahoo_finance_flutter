part of 'search_stock_bloc.dart';

abstract class SearchStockEvent extends Equatable {
  const SearchStockEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends SearchStockEvent {
  const FormChanged({
    this.symbolController,
  });

  final TextEditingController? symbolController;

  @override
  List<Object?> get props => [
        symbolController,
      ];
}

class SearchButtonTapped extends SearchStockEvent {}

class SearchStockFailed extends SearchStockEvent {}

class RetryTapped extends SearchStockEvent {}

class StockChartFetched extends SearchStockEvent {
  const StockChartFetched({
    required this.stock,
  });

  final Stock stock;

  @override
  List<Object?> get props => [
        stock,
      ];
}
