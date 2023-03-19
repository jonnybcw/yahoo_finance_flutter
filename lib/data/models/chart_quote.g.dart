// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartQuote _$ChartQuoteFromJson(Map<String, dynamic> json) => ChartQuote(
      volume: (json['volume'] as List<dynamic>).map((e) => e as int?).toList(),
      high: (json['high'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      close: (json['close'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      open: (json['open'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
      low: (json['low'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$ChartQuoteToJson(ChartQuote instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'high': instance.high,
      'close': instance.close,
      'open': instance.open,
      'low': instance.low,
    };
