import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculation_result.freezed.dart';

/// Represents the result of a string calculator operation
/// Contains the computed sum and metadata about the calculation
@freezed
abstract class CalculationResult with _$CalculationResult {
  const factory CalculationResult({
    /// The computed sum of all valid numbers
    required int sum,

    /// List of individual numbers that were processed
    required List<int> processedNumbers,

    /// List of delimiters that were used in parsing
    required List<String> usedDelimiters,

    /// The original input string
    required String originalInput,
  }) = _CalculationResult;

  const CalculationResult._();

  /// Factory constructor for successful calculation
  factory CalculationResult.success({
    required int sum,
    required List<int> processedNumbers,
    required List<String> usedDelimiters,
    required String originalInput,
  }) {
    return CalculationResult(
      sum: sum,
      processedNumbers: processedNumbers,
      usedDelimiters: usedDelimiters,
      originalInput: originalInput,
    );
  }

}
