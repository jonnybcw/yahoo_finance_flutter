// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_indicators.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartIndicators _$ChartIndicatorsFromJson(Map<String, dynamic> json) =>
    ChartIndicators(
      quote: (json['quote'] as List<dynamic>)
          .map((e) => ChartQuote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChartIndicatorsToJson(ChartIndicators instance) =>
    <String, dynamic>{
      'quote': instance.quote,
    };
