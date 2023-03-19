import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yahoo_finance_flutter/data/models/chart_result.dart';
import 'package:yahoo_finance_flutter/data/models/stock_variation.dart';
import 'package:yahoo_finance_flutter/modules/stock_variation/bloc/stock_variation_bloc.dart';
import 'package:yahoo_finance_flutter/modules/stock_variation/components/variation_chart_dialog.dart';
import 'package:yahoo_finance_flutter/util/components/error_component.dart';

class StockVariationScreen extends StatefulWidget {
  const StockVariationScreen({
    required this.chartResult,
    Key? key,
  }) : super(key: key);

  final ChartResult chartResult;

  @override
  State<StockVariationScreen> createState() => _StockVariationScreenState();
}

class _StockVariationScreenState extends State<StockVariationScreen> {
  late StockVariationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = StockVariationBloc(chartResult: widget.chartResult);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<StockVariationBloc, StockVariationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Historical Data'),
              actions: state is StockVariationResult
                  ? [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => VariationChartDialog(
                              stockVariation: state.stockVariation,
                            ),
                          );
                        },
                        icon: const Icon(Icons.show_chart),
                      ),
                    ]
                  : [],
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, StockVariationState state) {
    if (state is StockVariationResult) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Price',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Variation compared to D-1',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Variation compared to first date',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  StockVariation stockVariation = state.stockVariation[index];
                  return _getPriceRow(stockVariation);
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 1);
                },
                itemCount: state.stockVariation.length,
              ),
            ),
          ],
        ),
      );
    } else if (state is StockVariationFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryButtonTapped());
        },
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _getPriceRow(StockVariation stockVariation) {
    String date =
        '${DateFormat.yMd().format(stockVariation.date)}\n${DateFormat.jm().format(stockVariation.date)}';
    String? price = stockVariation.price?.toStringAsFixed(2);
    String? variationD1 = stockVariation.variationD1?.toStringAsFixed(2);
    String? variationFirstDate =
        stockVariation.variationFirstDate?.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(date),
          ),
          Expanded(
            child: price == null ? Container() : Text('R\$ $price'),
          ),
          Expanded(
            child: variationD1 == null ? Container() : Text('$variationD1%'),
          ),
          Expanded(
            child: variationFirstDate == null
                ? Container()
                : Text('$variationFirstDate%'),
          ),
        ],
      ),
    );
  }
}
