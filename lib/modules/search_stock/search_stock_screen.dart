import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahoo_finance_flutter/data/models/chart_result.dart';
import 'package:yahoo_finance_flutter/data/models/stock_chart.dart';
import 'package:yahoo_finance_flutter/modules/search_stock/bloc/search_stock_bloc.dart';
import 'package:yahoo_finance_flutter/modules/stock_variation/stock_variation_screen.dart';
import 'package:yahoo_finance_flutter/util/components/error_component.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({Key? key}) : super(key: key);

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  late SearchStockBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SearchStockBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<SearchStockBloc, SearchStockState>(
        listener: (context, state) {
          if (state is SearchStockSuccess) {
            StockChart? stockChart = state.stock.chart;
            ChartResult? chartResult = stockChart.result?.firstOrNull;
            if (chartResult != null) {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => StockVariationScreen(
                    chartResult: chartResult,
                  ),
                ),
              )
                  .then((value) {
                bloc.add(FormChanged());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Yahoo Finance'),
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, SearchStockState state) {
    if (state is SearchStockFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is SearchStockIdle) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Stock symbol',
              ),
              controller: state.nameFieldState.controller,
              onChanged: (t) {
                bloc.add(FormChanged());
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: state.isSearchButtonEnabled
                  ? () {
                      bloc.add(SearchButtonTapped());
                    }
                  : null,
              child: const Text('SEARCH'),
            )
          ],
        ),
      );
    } else if (state is SearchStockSuccess) {
      StockChart? stockChart = state.stock.chart;
      ChartResult? chartResult = stockChart.result?.firstOrNull;
      if (chartResult == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                stockChart.error ?? 'Failed to search stock',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                bloc.add(FormChanged());
              },
              child: const Text('OK'),
            )
          ],
        );
      }
    }
    return const Center(child: CircularProgressIndicator());
  }
}
