import '../../domain/entities/calculator_config.dart';

/// Data model for CalculatorConfig with JSON serialization support
/// Extends the domain entity and adds fromJson/toJson capabilities
class CalculatorConfigModel extends CalculatorConfig {
  const CalculatorConfigModel({
    super.defaultDelimiters = const [',', '\n'],
    super.allowNegativeNumbers = false,
    super.customDelimiterPrefix = '//',
    super.multiDelimiterStart = '[',
    super.multiDelimiterEnd = ']',
  });

  /// Creates a CalculatorConfigModel from JSON
  factory CalculatorConfigModel.fromJson(Map<String, dynamic> json) {
    return CalculatorConfigModel(
      defaultDelimiters: json['defaultDelimiters'] != null
          ? List<String>.from(json['defaultDelimiters'] as List)
          : const [',', '\n'],
      allowNegativeNumbers: json['allowNegativeNumbers'] as bool? ?? false,
      customDelimiterPrefix: json['customDelimiterPrefix'] as String? ?? '//',
      multiDelimiterStart: json['multiDelimiterStart'] as String? ?? '[',
      multiDelimiterEnd: json['multiDelimiterEnd'] as String? ?? ']',
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'defaultDelimiters': defaultDelimiters,
      'allowNegativeNumbers': allowNegativeNumbers,
      'customDelimiterPrefix': customDelimiterPrefix,
      'multiDelimiterStart': multiDelimiterStart,
      'multiDelimiterEnd': multiDelimiterEnd,
    };
  }

  /// Creates a model from a domain entity
  factory CalculatorConfigModel.fromEntity(CalculatorConfig entity) {
    return CalculatorConfigModel(
      defaultDelimiters: entity.defaultDelimiters,
      allowNegativeNumbers: entity.allowNegativeNumbers,
      customDelimiterPrefix: entity.customDelimiterPrefix,
      multiDelimiterStart: entity.multiDelimiterStart,
      multiDelimiterEnd: entity.multiDelimiterEnd,
    );
  }

  /// Converts this model to a domain entity
  CalculatorConfig toEntity() {
    return CalculatorConfig(
      defaultDelimiters: defaultDelimiters,
      allowNegativeNumbers: allowNegativeNumbers,
      customDelimiterPrefix: customDelimiterPrefix,
      multiDelimiterStart: multiDelimiterStart,
      multiDelimiterEnd: multiDelimiterEnd,
    );
  }

  /// Factory constructor for default configuration
  factory CalculatorConfigModel.defaultConfig() {
    return const CalculatorConfigModel();
  }

  /// Factory constructor for lenient configuration (allows negatives)
  factory CalculatorConfigModel.lenient() {
    return const CalculatorConfigModel(allowNegativeNumbers: true);
  }
}
