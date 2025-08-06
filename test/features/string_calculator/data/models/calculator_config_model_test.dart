import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator/features/string_calculator/data/models/calculator_config_model.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/calculator_config.dart';

void main() {
  group('CalculatorConfigModel', () {
    final tCalculatorConfigModel = CalculatorConfigModel(
      defaultDelimiters: [',', '\n'],
      allowNegativeNumbers: false,
      customDelimiterPrefix: '//',
      multiDelimiterStart: '[',
      multiDelimiterEnd: ']',
    );

    final tCalculatorConfig = CalculatorConfig(
      defaultDelimiters: [',', '\n'],
      allowNegativeNumbers: false,
      customDelimiterPrefix: '//',
      multiDelimiterStart: '[',
      multiDelimiterEnd: ']',
    );

    test('should be a subclass of CalculatorConfig entity', () {
      // Assert
      expect(tCalculatorConfigModel, isA<CalculatorConfig>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'defaultDelimiters': [',', '\n'],
          'allowNegativeNumbers': false,
          'customDelimiterPrefix': '//',
          'multiDelimiterStart': '[',
          'multiDelimiterEnd': ']',
        };

        // Act
        final result = CalculatorConfigModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tCalculatorConfigModel));
      });

      test('should use default values for missing fields', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'allowNegativeNumbers': true,
          // Other fields missing - should use defaults
        };

        // Act
        final result = CalculatorConfigModel.fromJson(jsonMap);

        // Assert
        expect(result.allowNegativeNumbers, equals(true));
        expect(result.defaultDelimiters, equals([',', '\n'])); // default
        expect(result.customDelimiterPrefix, equals('//')); // default
      });

      test('should handle empty defaultDelimiters list', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'defaultDelimiters': [],
          'allowNegativeNumbers': false,
        };

        // Act
        final result = CalculatorConfigModel.fromJson(jsonMap);

        // Assert
        expect(result.defaultDelimiters, isEmpty);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tCalculatorConfigModel.toJson();

        // Assert
        final expectedMap = {
          'defaultDelimiters': [',', '\n'],
          'allowNegativeNumbers': false,
          'customDelimiterPrefix': '//',
          'multiDelimiterStart': '[',
          'multiDelimiterEnd': ']',
        };
        expect(result, equals(expectedMap));
      });

      test('should handle custom configuration correctly', () {
        // Arrange
        final customConfig = CalculatorConfigModel(
          defaultDelimiters: [';', '|'],
          allowNegativeNumbers: true,
          customDelimiterPrefix: '##',
          multiDelimiterStart: '(',
          multiDelimiterEnd: ')',
        );

        // Act
        final result = customConfig.toJson();

        // Assert
        expect(result['defaultDelimiters'], equals([';', '|']));
        expect(result['allowNegativeNumbers'], equals(true));
        expect(result['customDelimiterPrefix'], equals('##'));
        expect(result['multiDelimiterStart'], equals('('));
        expect(result['multiDelimiterEnd'], equals(')'));
      });
    });

    group('fromEntity', () {
      test('should create model from entity', () {
        // Act
        final result = CalculatorConfigModel.fromEntity(tCalculatorConfig);

        // Assert
        expect(
          result.defaultDelimiters,
          equals(tCalculatorConfig.defaultDelimiters),
        );
        expect(
          result.allowNegativeNumbers,
          equals(tCalculatorConfig.allowNegativeNumbers),
        );
        expect(
          result.customDelimiterPrefix,
          equals(tCalculatorConfig.customDelimiterPrefix),
        );
        expect(
          result.multiDelimiterStart,
          equals(tCalculatorConfig.multiDelimiterStart),
        );
        expect(
          result.multiDelimiterEnd,
          equals(tCalculatorConfig.multiDelimiterEnd),
        );
      });
    });

    group('toEntity', () {
      test('should convert model to entity', () {
        // Act
        final result = tCalculatorConfigModel.toEntity();

        // Assert
        expect(result, isA<CalculatorConfig>());
        expect(
          result.defaultDelimiters,
          equals(tCalculatorConfigModel.defaultDelimiters),
        );
        expect(
          result.allowNegativeNumbers,
          equals(tCalculatorConfigModel.allowNegativeNumbers),
        );
        expect(
          result.customDelimiterPrefix,
          equals(tCalculatorConfigModel.customDelimiterPrefix),
        );
        expect(
          result.multiDelimiterStart,
          equals(tCalculatorConfigModel.multiDelimiterStart),
        );
        expect(
          result.multiDelimiterEnd,
          equals(tCalculatorConfigModel.multiDelimiterEnd),
        );
      });
    });

    group('JSON serialization round trip', () {
      test(
        'should maintain data integrity through serialize/deserialize cycle',
        () {
          // Act
          final json = tCalculatorConfigModel.toJson();
          final jsonString = jsonEncode(json);
          final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
          final result = CalculatorConfigModel.fromJson(decodedJson);

          // Assert
          expect(result, equals(tCalculatorConfigModel));
        },
      );
    });

    group('Predefined configurations', () {
      test('should create default config model correctly', () {
        // Act
        final result = CalculatorConfigModel.defaultConfig();

        // Assert
        expect(result.defaultDelimiters, equals([',', '\n']));
        expect(result.allowNegativeNumbers, equals(false));
      });

      test('should create lenient config model correctly', () {
        // Act
        final result = CalculatorConfigModel.lenient();

        // Assert
        expect(result.allowNegativeNumbers, equals(true));
      });
    });
  });
}
