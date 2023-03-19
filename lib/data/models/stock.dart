import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yahoo_finance_flutter/data/models/stock_chart.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock extends Equatable {
  const Stock({
    required this.chart,
  });

  final StockChart chart;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  @override
  List<Object?> get props => [
        chart,
      ];
}
