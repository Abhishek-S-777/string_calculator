/// Configuration settings for the string calculator
class CalculatorConfig {
  /// Default delimiters to use when no custom delimiter is specified
  final List<String> defaultDelimiters;

  /// Whether negative numbers should be allowed
  final bool allowNegativeNumbers;

  /// Custom delimiter prefix pattern
  final String customDelimiterPrefix;

  /// Pattern for multi-character delimiter enclosure
  final String multiDelimiterStart;
  final String multiDelimiterEnd;

  const CalculatorConfig({
    this.defaultDelimiters = const [',', '\n'],
    this.allowNegativeNumbers = false,
    this.customDelimiterPrefix = '//',
    this.multiDelimiterStart = '[',
    this.multiDelimiterEnd = ']',
  });

  /// Factory constructor for default configuration
  factory CalculatorConfig.defaultConfig() {
    return const CalculatorConfig();
  }

  /// Factory constructor for lenient configuration (allows negatives)
  factory CalculatorConfig.lenient() {
    return const CalculatorConfig(allowNegativeNumbers: true);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CalculatorConfig) return false;
    return _listEquals(defaultDelimiters, other.defaultDelimiters) &&
        allowNegativeNumbers == other.allowNegativeNumbers &&
        customDelimiterPrefix == other.customDelimiterPrefix &&
        multiDelimiterStart == other.multiDelimiterStart &&
        multiDelimiterEnd == other.multiDelimiterEnd;
  }

  @override
  int get hashCode {
    return defaultDelimiters.hashCode ^
        allowNegativeNumbers.hashCode ^
        customDelimiterPrefix.hashCode ^
        multiDelimiterStart.hashCode ^
        multiDelimiterEnd.hashCode;
  }

  @override
  String toString() {
    return 'CalculatorConfig(defaultDelimiters: $defaultDelimiters, allowNegativeNumbers: $allowNegativeNumbers, customDelimiterPrefix: $customDelimiterPrefix, multiDelimiterStart: $multiDelimiterStart, multiDelimiterEnd: $multiDelimiterEnd)';
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
