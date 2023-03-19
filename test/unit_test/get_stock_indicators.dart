import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yahoo_finance_flutter/data/api/api_constants.dart';
import 'package:yahoo_finance_flutter/data/api/finance_api.dart';
import 'package:yahoo_finance_flutter/data/models/field_state.dart';
import 'package:yahoo_finance_flutter/data/models/stock.dart';
import 'package:yahoo_finance_flutter/modules/search_stock/bloc/search_stock_bloc.dart';

import 'data/repositories/mock_finance_repository.dart';
import 'get_stock_indicators.mocks.dart';

// Generate a MockDio using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([Dio])
void main() {
  group('FinanceApi test', () {
    Map<String, dynamic> expectedApiSuccessJson = {
      'chart': {
        'result': [
          {
            'timestamp': List.generate(30, (index) => index),
            'indicators': {
              'quote': [
                {
                  'volume': List.generate(30, (index) => index),
                  'high': List.generate(30, (index) => index),
                  'close': List.generate(30, (index) => index),
                  'open': List.generate(30, (index) => index),
                  'low': List.generate(30, (index) => index),
                }
              ]
            }
          }
        ],
        'error': null,
      }
    };
    Map<String, dynamic> expectedApiErrorJson = {
      'chart': {
        'result': null,
        'error': 'Not Found',
      },
    };

    test('returns a Stock if the http call completes successfully', () async {
      final client = MockDio();
      String symbol = 'PETR4.SA';
      String path = ApiConstants.chart(symbol);

      // Use Mockito to return a successful response when it calls the
      // provided Dio.
      when(client.get(path)).thenAnswer((_) async => Response(
            data: expectedApiSuccessJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          ));

      expect(
        await FinanceApi.getStockIndicators(client: client, symbol: symbol),
        isA<Stock>(),
      );
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockDio();
      String symbol = 'PETR5';
      String path = ApiConstants.chart(symbol);

      // Use Mockito to return an unsuccessful response when it calls the
      // provided Dio.
      when(client.get(path)).thenAnswer((_) async => Response(
            data: expectedApiErrorJson,
            statusMessage: 'Not Found',
            statusCode: 404,
            requestOptions: RequestOptions(path: path),
          ));

      expect(
        await FinanceApi.getStockIndicators(client: client, symbol: symbol),
        isA<Stock>().having(
          (e) => e.chart.error,
          'Error message is not null',
          isNotNull,
        ),
      );
    });
  });

  group('SearchStockBloc test', () {
    late SearchStockBloc bloc;

    setUp(() {
      MockFinanceRepository financeRepository = MockFinanceRepository();
      bloc = SearchStockBloc(financeRepository: financeRepository);
    });

    blocTest<SearchStockBloc, SearchStockState>(
      'emits [SearchStockInitial, SearchStockSuccess] when text field is empty',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchButtonTapped()),
      expect: () => [
        SearchStockInitial(),
        SearchStockSuccess(stock: stockInvalidSymbol),
      ],
    );

    TextEditingController symbolController = TextEditingController();
    blocTest<SearchStockBloc, SearchStockState>(
      'emits [SearchStockIdle, SearchStockInitial, SearchStockSuccess] when text field is not empty',
      build: () => bloc,
      act: (bloc) {
        symbolController.text = 'PETR4.SA';
        bloc.add(FormChanged(symbolController: symbolController));
        bloc.add(SearchButtonTapped());
      },
      expect: () => [
        SearchStockIdle(
          nameFieldState: FieldState(
            controller: symbolController,
            text: symbolController.text,
          ),
          isSearchButtonEnabled: true,
        ),
        SearchStockInitial(),
        SearchStockSuccess(stock: stockIndicators),
      ],
    );

    tearDown(() => bloc.close());
  });
}
