import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:yahoo_finance_flutter/data/models/field_state.dart';
import 'package:yahoo_finance_flutter/data/models/stock.dart';
import 'package:yahoo_finance_flutter/data/repositories/finance_repository.dart';

part 'search_stock_event.dart';
part 'search_stock_state.dart';

class SearchStockBloc extends Bloc<SearchStockEvent, SearchStockState> {
  SearchStockBloc({FinanceRepository? financeRepository})
      : super(SearchStockInitial()) {
    on<FormChanged>((event, emit) {
      TextEditingController? symbolController = event.symbolController;
      if (symbolController != null) _stockSymbolController = symbolController;
      emit(_getIdleState());
    });
    on<SearchButtonTapped>((event, emit) {
      emit(SearchStockInitial());
      _searchStock();
    });
    on<SearchStockFailed>((event, emit) {
      emit(SearchStockFailure());
    });
    on<RetryTapped>((event, emit) {
      emit(_getIdleState());
    });
    on<StockChartFetched>((event, emit) {
      emit(SearchStockSuccess(stock: event.stock));
    });

    _financeRepository = financeRepository ?? GetIt.I<FinanceRepository>();

    add(const FormChanged());
  }

  TextEditingController _stockSymbolController = TextEditingController();
  late final FinanceRepository _financeRepository;

  SearchStockIdle _getIdleState() {
    return SearchStockIdle(
      nameFieldState: _getStockSymbolFieldState(),
      isSearchButtonEnabled: _isSearchButtonEnabled(),
    );
  }

  FieldState _getStockSymbolFieldState() {
    return FieldState(
      controller: _stockSymbolController,
      text: _stockSymbolController.text,
    );
  }

  bool _isSearchButtonEnabled() {
    return _stockSymbolController.text.isNotEmpty;
  }

  Future<void> _searchStock() async {
    try {
      Stock stock = await _financeRepository.getStockIndicators(
        symbol: _stockSymbolController.text,
      );
      add(StockChartFetched(stock: stock));
    } catch (e) {
      add(SearchStockFailed());
    }
  }
}
