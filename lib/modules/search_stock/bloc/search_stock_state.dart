part of 'search_stock_bloc.dart';

abstract class SearchStockState extends Equatable {
  const SearchStockState();

  @override
  List<Object?> get props => [];
}

class SearchStockInitial extends SearchStockState {}

class SearchStockIdle extends SearchStockState {
  const SearchStockIdle({
    required this.nameFieldState,
    required this.isSearchButtonEnabled,
  });

  final FieldState nameFieldState;
  final bool isSearchButtonEnabled;

  @override
  List<Object?> get props => [
        nameFieldState,
        isSearchButtonEnabled,
      ];
}

class SearchStockFailure extends SearchStockState {}

class SearchStockSuccess extends SearchStockState {
  const SearchStockSuccess({
    required this.stock,
  });

  final Stock stock;

  @override
  List<Object?> get props => [
        stock,
      ];
}
