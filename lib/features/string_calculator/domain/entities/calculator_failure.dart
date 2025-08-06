/// Represents different types of failures that can occur during calculation
class CalculatorFailure {
  final String message;
  final String? input;
  final List<int>? negativeNumbers;
  final CalculatorFailureType type;

  const CalculatorFailure._({
    required this.message,
    required this.type,
    this.input,
    this.negativeNumbers,
  });

  /// Failure when negative numbers are provided
  factory CalculatorFailure.negativesNotAllowed({
    required List<int> negativeNumbers,
    String? customMessage,
  }) {
    final message =
        customMessage ?? 'Negatives not allowed: ${negativeNumbers.join(', ')}';
    return CalculatorFailure._(
      message: message,
      type: CalculatorFailureType.negativesNotAllowed,
      negativeNumbers: negativeNumbers,
    );
  }

  /// Failure when input format is invalid
  factory CalculatorFailure.invalidFormat({
    required String input,
    String? details,
  }) {
    final message =
        'Invalid input format${details != null ? ': $details' : ''}';
    return CalculatorFailure._(
      message: message,
      type: CalculatorFailureType.invalidFormat,
      input: input,
    );
  }

  /// Failure when delimiter format is invalid
  factory CalculatorFailure.invalidDelimiter({
    required String delimiterPart,
    String? details,
  }) {
    final message =
        'Invalid delimiter format${details != null ? ': $details' : ''}';
    return CalculatorFailure._(
      message: message,
      type: CalculatorFailureType.invalidDelimiter,
      input: delimiterPart,
    );
  }

  /// General parsing failure
  factory CalculatorFailure.parsingError({
    required String input,
    String? details,
  }) {
    final message =
        'Failed to parse input${details != null ? ': $details' : ''}';
    return CalculatorFailure._(
      message: message,
      type: CalculatorFailureType.parsingError,
      input: input,
    );
  }
}

/// Enum representing different types of calculator failures
enum CalculatorFailureType {
  negativesNotAllowed,
  invalidFormat,
  invalidDelimiter,
  parsingError,
}
