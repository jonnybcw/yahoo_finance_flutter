import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yahoo_finance_flutter/data/models/stock_variation.dart';

class VariationChartDialog extends StatelessWidget {
  const VariationChartDialog({
    required this.stockVariation,
    Key? key,
  }) : super(key: key);

  final List<StockVariation> stockVariation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Chart',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 500,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: stockVariation.asMap().entries.map((entry) {
                        StockVariation item = entry.value;
                        double index = entry.key * 1.0;
                        double? price = item.price;
                        if (price == null) {
                          return FlSpot.nullSpot;
                        }
                        return FlSpot(index, price);
                      }).toList(),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      getTooltipItems: tooltipItems,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<LineTooltipItem?> tooltipItems(List<LineBarSpot> lineBarSpot) {
    return lineBarSpot.map((e) {
      DateTime date = stockVariation.elementAt(e.x.toInt()).date;
      String dateStr =
          '${DateFormat.yMd().format(date)}\n${DateFormat.jm().format(date)}';
      return LineTooltipItem(
        'R\$ ${e.y.toStringAsFixed(6)}\n\n$dateStr',
        const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    }).toList();
  }
}
