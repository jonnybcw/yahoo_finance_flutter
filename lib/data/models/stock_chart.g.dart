// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockChart _$StockChartFromJson(Map<String, dynamic> json) => StockChart(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ChartResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$StockChartToJson(StockChart instance) =>
    <String, dynamic>{
      'result': instance.result,
      'error': instance.error,
    };
