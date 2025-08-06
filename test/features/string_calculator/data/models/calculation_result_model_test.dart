import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator/features/string_calculator/data/models/calculation_result_model.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/calculation_result.dart';

void main() {
  group('CalculationResultModel', () {
    const tCalculationResultModel = CalculationResultModel(
      sum: 6,
      processedNumbers: [1, 2, 3],
      usedDelimiters: [',', '\n'],
      originalInput: '1,2,3,1001',
    );

    const tCalculationResult = CalculationResult(
      sum: 6,
      processedNumbers: [1, 2, 3],
      usedDelimiters: [',', '\n'],
      originalInput: '1,2,3,1001',
    );

    test('should be a subclass of CalculationResult entity', () {
      // Assert
      expect(tCalculationResultModel, isA<CalculationResult>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'sum': 6,
          'processedNumbers': [1, 2, 3],
          'usedDelimiters': [',', '\n'],
          'originalInput': '1,2,3,1001',
        };

        // Act
        final result = CalculationResultModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tCalculationResultModel));
      });

      test('should handle empty lists correctly', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'sum': 0,
          'processedNumbers': [],
          'usedDelimiters': [',', '\n'],
          'originalInput': '',
        };

        // Act
        final result = CalculationResultModel.fromJson(jsonMap);

        // Assert
        expect(result.sum, equals(0));
        expect(result.processedNumbers, isEmpty);
        expect(result.originalInput, equals(''));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tCalculationResultModel.toJson();

        // Assert
        final expectedMap = {
          'sum': 6,
          'processedNumbers': [1, 2, 3],
          'usedDelimiters': [',', '\n'],
          'originalInput': '1,2,3,1001',
        };
        expect(result, equals(expectedMap));
      });

      test('should handle empty lists correctly', () {
        // Arrange
        const model = CalculationResultModel(
          sum: 0,
          processedNumbers: [],
          usedDelimiters: [],
          originalInput: '',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['processedNumbers'], isEmpty);
        expect(result['usedDelimiters'], isEmpty);
      });
    });

    group('fromEntity', () {
      test('should create model from entity', () {
        // Act
        final result = CalculationResultModel.fromEntity(tCalculationResult);

        // Assert
        expect(result.sum, equals(tCalculationResult.sum));
        expect(
          result.processedNumbers,
          equals(tCalculationResult.processedNumbers),
        );
        expect(
          result.usedDelimiters,
          equals(tCalculationResult.usedDelimiters),
        );
        expect(result.originalInput, equals(tCalculationResult.originalInput));
      });
    });

    group('toEntity', () {
      test('should convert model to entity', () {
        // Act
        final result = tCalculationResultModel.toEntity();

        // Assert
        expect(result, isA<CalculationResult>());
        expect(result.sum, equals(tCalculationResultModel.sum));
        expect(
          result.processedNumbers,
          equals(tCalculationResultModel.processedNumbers),
        );
        expect(
          result.usedDelimiters,
          equals(tCalculationResultModel.usedDelimiters),
        );
        expect(
          result.originalInput,
          equals(tCalculationResultModel.originalInput),
        );
      });
    });

    group('JSON serialization round trip', () {
      test(
        'should maintain data integrity through serialize/deserialize cycle',
        () {
          // Act
          final json = tCalculationResultModel.toJson();
          final jsonString = jsonEncode(json);
          final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
          final result = CalculationResultModel.fromJson(decodedJson);

          // Assert
          expect(result, equals(tCalculationResultModel));
        },
      );
    });
  });
}
