/// Custom exception for string calculator operations
class CalculatorException implements Exception {
  final String message;
  final String? input;
  final List<int>? negativeNumbers;

  const CalculatorException({
    required this.message,
    this.input,
    this.negativeNumbers,
  });

  /// Factory constructor for negative numbers exception
  factory CalculatorException.negativesNotAllowed(List<int> negativeNumbers) {
    return CalculatorException(
      message: 'Negatives not allowed: ${negativeNumbers.join(', ')}',
      negativeNumbers: negativeNumbers,
    );
  }

  /// Factory constructor for invalid format exception
  factory CalculatorException.invalidFormat(String input, [String? details]) {
    return CalculatorException(
      message: 'Invalid input format${details != null ? ': $details' : ''}',
      input: input,
    );
  }

  /// Factory constructor for invalid delimiter exception
  factory CalculatorException.invalidDelimiter(String delimiterPart) {
    return CalculatorException(
      message: 'Invalid delimiter format: $delimiterPart',
      input: delimiterPart,
    );
  }

  /// Factory constructor for parsing errors
  factory CalculatorException.parsingError(String input, [String? details]) {
    return CalculatorException(
      message: 'Failed to parse input${details != null ? ': $details' : ''}',
      input: input,
    );
  }

  @override
  String toString() {
    return 'CalculatorException: $message';
  }
}
