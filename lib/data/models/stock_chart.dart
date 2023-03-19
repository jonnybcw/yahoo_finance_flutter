import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yahoo_finance_flutter/data/models/chart_result.dart';

part 'stock_chart.g.dart';

@JsonSerializable()
class StockChart extends Equatable {
  const StockChart({
    required this.result,
    required this.error,
  });

  final List<ChartResult>? result;
  final String? error;

  factory StockChart.fromJson(Map<String, dynamic> json) =>
      _$StockChartFromJson(json);

  Map<String, dynamic> toJson() => _$StockChartToJson(this);

  @override
  List<Object?> get props => [
        result,
        error,
      ];
}
