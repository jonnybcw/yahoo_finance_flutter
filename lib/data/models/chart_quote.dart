import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_quote.g.dart';

@JsonSerializable()
class ChartQuote extends Equatable {
  const ChartQuote({
    required this.volume,
    required this.high,
    required this.close,
    required this.open,
    required this.low,
  });

  final List<int?> volume;
  final List<double?> high;
  final List<double?> close;
  final List<double?> open;
  final List<double?> low;

  factory ChartQuote.fromJson(Map<String, dynamic> json) =>
      _$ChartQuoteFromJson(json);

  Map<String, dynamic> toJson() => _$ChartQuoteToJson(this);

  @override
  List<Object?> get props => [
        volume,
        high,
        close,
        open,
        low,
      ];
}
