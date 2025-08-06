/// Represents the result of a string calculator operation
/// Contains the computed sum and metadata about the calculation
class CalculationResult {
  /// The computed sum of all valid numbers
  final int sum;

  /// List of individual numbers that were processed
  final List<int> processedNumbers;

  /// List of delimiters that were used in parsing
  final List<String> usedDelimiters;

  /// The original input string
  final String originalInput;

  const CalculationResult({
    required this.sum,
    required this.processedNumbers,
    required this.usedDelimiters,
    required this.originalInput,
  });

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CalculationResult) return false;
    return sum == other.sum &&
        _listEquals(processedNumbers, other.processedNumbers) &&
        _listEquals(usedDelimiters, other.usedDelimiters) &&
        originalInput == other.originalInput;
  }

  @override
  int get hashCode {
    return sum.hashCode ^
        processedNumbers.hashCode ^
        usedDelimiters.hashCode ^
        originalInput.hashCode;
  }

  @override
  String toString() {
    return 'CalculationResult(sum: $sum, processedNumbers: $processedNumbers, usedDelimiters: $usedDelimiters, originalInput: $originalInput)';
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index++) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}
