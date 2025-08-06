import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_config.freezed.dart';

/// Configuration settings for the string calculator
@freezed
abstract class CalculatorConfig with _$CalculatorConfig {
  const factory CalculatorConfig({
    /// Default delimiters to use when no custom delimiter is specified
    @Default([',', '\n']) List<String> defaultDelimiters,

    /// Whether negative numbers should be allowed
    @Default(false) bool allowNegativeNumbers,

    /// Custom delimiter prefix pattern
    @Default('//') String customDelimiterPrefix,

    /// Pattern for multi-character delimiter enclosure
    @Default('[') String multiDelimiterStart,
    @Default(']') String multiDelimiterEnd,
  }) = _CalculatorConfig;

  const CalculatorConfig._();

  /// Factory constructor for default configuration
  factory CalculatorConfig.defaultConfig() {
    return const CalculatorConfig();
  }

  /// Factory constructor for lenient configuration (allows negatives)
  factory CalculatorConfig.lenient() {
    return const CalculatorConfig(allowNegativeNumbers: true);
  }
}
