/// Represents the parsed input from the string calculator
/// Contains the extracted numbers and delimiters from the raw input
class ParsedInput {
  /// The original raw input string
  final String rawInput;

  /// List of delimiters found in the input (default: [',', '\n'])
  final List<String> delimiters;

  /// The numbers part of the input (without delimiter declarations)
  final String numbersString;

  /// Whether custom delimiters were specified in the input
  final bool hasCustomDelimiters;

  const ParsedInput({
    required this.rawInput,
    required this.delimiters,
    required this.numbersString,
    this.hasCustomDelimiters = false,
  });

  /// Factory constructor for creating ParsedInput with default delimiters
  factory ParsedInput.withDefaults(String rawInput) {
    return ParsedInput(
      rawInput: rawInput,
      delimiters: [',', '\n'],
      numbersString: rawInput,
      hasCustomDelimiters: false,
    );
  }

  /// Factory constructor for creating ParsedInput with custom delimiters
  factory ParsedInput.withCustomDelimiters({
    required String rawInput,
    required List<String> customDelimiters,
    required String numbersString,
  }) {
    return ParsedInput(
      rawInput: rawInput,
      delimiters: customDelimiters,
      numbersString: numbersString,
      hasCustomDelimiters: true,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ParsedInput) return false;
    return rawInput == other.rawInput &&
        _listEquals(delimiters, other.delimiters) &&
        numbersString == other.numbersString &&
        hasCustomDelimiters == other.hasCustomDelimiters;
  }

  @override
  int get hashCode {
    return rawInput.hashCode ^
        delimiters.hashCode ^
        numbersString.hashCode ^
        hasCustomDelimiters.hashCode;
  }

  @override
  String toString() {
    return 'ParsedInput(rawInput: $rawInput, delimiters: $delimiters, numbersString: $numbersString, hasCustomDelimiters: $hasCustomDelimiters)';
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
