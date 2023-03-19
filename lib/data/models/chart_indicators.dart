import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yahoo_finance_flutter/data/models/chart_quote.dart';

part 'chart_indicators.g.dart';

@JsonSerializable()
class ChartIndicators extends Equatable {
  const ChartIndicators({
    required this.quote,
  });

  final List<ChartQuote> quote;

  factory ChartIndicators.fromJson(Map<String, dynamic> json) =>
      _$ChartIndicatorsFromJson(json);

  Map<String, dynamic> toJson() => _$ChartIndicatorsToJson(this);

  @override
  List<Object?> get props => [
        quote,
      ];
}
