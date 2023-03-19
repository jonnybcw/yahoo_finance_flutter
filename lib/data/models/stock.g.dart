// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      chart: StockChart.fromJson(json['chart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'chart': instance.chart,
    };
