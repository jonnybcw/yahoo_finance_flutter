// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartResult _$ChartResultFromJson(Map<String, dynamic> json) => ChartResult(
      timestamp:
          (json['timestamp'] as List<dynamic>?)?.map((e) => e as int).toList(),
      indicators:
          ChartIndicators.fromJson(json['indicators'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChartResultToJson(ChartResult instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'indicators': instance.indicators,
    };
