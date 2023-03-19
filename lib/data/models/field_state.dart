import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class FieldState extends Equatable {
  const FieldState({
    required this.controller,
    required this.text,
    this.error,
  });

  final TextEditingController controller;
  final String text;
  final String? error;

  @override
  List<Object?> get props => [
        controller,
        text,
        error,
      ];
}
