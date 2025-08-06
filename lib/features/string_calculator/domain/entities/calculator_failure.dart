import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_failure.freezed.dart';

/// Represents different types of failures that can occur during calculation
@freezed
abstract class CalculatorFailure with _$CalculatorFailure {
  /// Failure when negative numbers are provided
  const factory CalculatorFailure.negativesNotAllowed({
    required List<int> negativeNumbers,
    required String message,
  }) = _NegativesNotAllowed;

  /// General parsing failure
  const factory CalculatorFailure.parsingError({
    required String input,
    required String message,
  }) = _ParsingError;
}
