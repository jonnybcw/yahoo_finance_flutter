import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yahoo_finance_flutter/data/models/chart_indicators.dart';

part 'chart_result.g.dart';

@JsonSerializable()
class ChartResult extends Equatable {
  const ChartResult({
    required this.timestamp,
    required this.indicators,
  });

  final List<int>? timestamp;
  final ChartIndicators indicators;

  factory ChartResult.fromJson(Map<String, dynamic> json) =>
      _$ChartResultFromJson(json);

  Map<String, dynamic> toJson() => _$ChartResultToJson(this);

  @override
  List<Object?> get props => [
        timestamp,
        indicators,
      ];
}
