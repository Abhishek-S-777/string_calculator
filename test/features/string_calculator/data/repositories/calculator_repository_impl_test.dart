import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator/core/errors/calculator_exception.dart';
import 'package:string_calculator/features/string_calculator/data/repositories/calculator_repository_impl.dart';
import 'package:string_calculator/features/string_calculator/domain/repositories/calculator_repository.dart';

void main() {
  late CalculatorRepository repository;

  setUp(() {
    repository = CalculatorRepositoryImpl();
  });

  group('CalculatorRepositoryImpl', () {
    group('add', () {
      test('should return 0 for empty string', () async {
        // Act
        final result = await repository.add('');

        // Assert
        expect(result.sum, equals(0));
        expect(result.processedNumbers, isEmpty);
        expect(result.originalInput, equals(''));
        expect(result.usedDelimiters, contains(','));
        expect(result.usedDelimiters, contains('\n'));
      });

      test('should return the number itself for single number', () async {
        // Act
        final result = await repository.add('1');

        // Assert
        expect(result.sum, equals(1));
        expect(result.processedNumbers, equals([1]));
        expect(result.originalInput, equals('1'));
      });

      test('should handle two numbers separated by comma', () async {
        // Act
        final result = await repository.add('1,2');

        // Assert
        expect(result.sum, equals(3));
        expect(result.processedNumbers, equals([1, 2]));
        expect(result.originalInput, equals('1,2'));
      });

      test('should handle multiple numbers separated by comma', () async {
        // Act
        final result = await repository.add('1,2,3,4,5');

        // Assert
        expect(result.sum, equals(15));
        expect(result.processedNumbers, equals([1, 2, 3, 4, 5]));
      });

      test('should handle numbers separated by newline', () async {
        // Act
        final result = await repository.add('1\n2,3');

        // Assert
        expect(result.sum, equals(6));
        expect(result.processedNumbers, equals([1, 2, 3]));
      });

      test('should handle custom single character delimiter', () async {
        // Act
        final result = await repository.add('//;\n1;2');

        // Assert
        expect(result.sum, equals(3));
        expect(result.processedNumbers, equals([1, 2]));
        expect(result.usedDelimiters, contains(';'));
        expect(result.usedDelimiters, contains(','));
        expect(result.usedDelimiters, contains('\n'));
      });

      test('should handle custom multi-character delimiter', () async {
        // Act
        final result = await repository.add('//[***]\n1***2***3');

        // Assert
        expect(result.sum, equals(6));
        expect(result.processedNumbers, equals([1, 2, 3]));
        expect(result.usedDelimiters, contains('***'));
      });

      test('should handle multiple custom delimiters', () async {
        // Act
        final result = await repository.add('//[*][%]\n1*2%3');

        // Assert
        expect(result.sum, equals(6));
        expect(result.processedNumbers, equals([1, 2, 3]));
        expect(result.usedDelimiters, contains('*'));
        expect(result.usedDelimiters, contains('%'));
      });

      test('should throw exception for negative numbers', () async {
        // Act & Assert
        expect(
          () async => await repository.add('1,-2,3'),
          throwsA(
            predicate(
              (e) =>
                  e is CalculatorException &&
                  e.message.contains('Negatives not allowed') &&
                  e.message.contains('-2'),
            ),
          ),
        );
      });

      test('should throw exception for multiple negative numbers', () async {
        // Act & Assert
        expect(
          () async => await repository.add('1,-2,-3,4'),
          throwsA(
            predicate(
              (e) =>
                  e is CalculatorException &&
                  e.message.contains('Negatives not allowed') &&
                  e.message.contains('-2') &&
                  e.message.contains('-3'),
            ),
          ),
        );
      });

      test('should throw exception for invalid number format', () async {
        // Act & Assert
        expect(
          () async => await repository.add('1,abc,3'),
          throwsA(isA<CalculatorException>()),
        );
      });
    });
  });
}
