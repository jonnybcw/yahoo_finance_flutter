import 'package:equatable/equatable.dart';

class StockVariation extends Equatable {
  const StockVariation({
    required this.date,
    required this.price,
    required this.variationD1,
    required this.variationFirstDate,
  });

  final DateTime date;
  final double? price;
  final double? variationD1;
  final double? variationFirstDate;

  @override
  List<Object?> get props => [
        date,
        price,
        variationD1,
        variationFirstDate,
      ];
}
