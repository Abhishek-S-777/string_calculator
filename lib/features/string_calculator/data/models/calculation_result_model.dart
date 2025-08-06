import '../../domain/entities/calculation_result.dart';

/// Data model for CalculationResult with JSON serialization support
/// Extends the domain entity and adds fromJson/toJson capabilities
class CalculationResultModel extends CalculationResult {
  const CalculationResultModel({
    required super.sum,
    required super.processedNumbers,
    required super.usedDelimiters,
    required super.originalInput,
  });

  /// Creates a CalculationResultModel from JSON
  factory CalculationResultModel.fromJson(Map<String, dynamic> json) {
    return CalculationResultModel(
      sum: json['sum'] as int,
      processedNumbers: List<int>.from(json['processedNumbers'] as List),
      usedDelimiters: List<String>.from(json['usedDelimiters'] as List),
      originalInput: json['originalInput'] as String,
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'sum': sum,
      'processedNumbers': processedNumbers,
      'usedDelimiters': usedDelimiters,
      'originalInput': originalInput,
    };
  }

  /// Creates a model from a domain entity
  factory CalculationResultModel.fromEntity(CalculationResult entity) {
    return CalculationResultModel(
      sum: entity.sum,
      processedNumbers: entity.processedNumbers,
      usedDelimiters: entity.usedDelimiters,
      originalInput: entity.originalInput,
    );
  }

  /// Converts this model to a domain entity
  CalculationResult toEntity() {
    return CalculationResult(
      sum: sum,
      processedNumbers: processedNumbers,
      usedDelimiters: usedDelimiters,
      originalInput: originalInput,
    );
  }

  /// Factory constructor for successful calculation model
  factory CalculationResultModel.success({
    required int sum,
    required List<int> processedNumbers,
    required List<String> usedDelimiters,
    required String originalInput,
  }) {
    return CalculationResultModel(
      sum: sum,
      processedNumbers: processedNumbers,
      usedDelimiters: usedDelimiters,
      originalInput: originalInput,
    );
  }
}
