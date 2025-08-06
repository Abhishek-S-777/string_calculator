import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:string_calculator/core/errors/calculator_exception.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/calculation_result.dart';
import 'package:string_calculator/features/string_calculator/domain/repositories/calculator_repository.dart';
import 'package:string_calculator/features/string_calculator/domain/usecases/calculate_string_use_case.dart';

import 'calculate_string_use_case_test.mocks.dart';

@GenerateMocks([CalculatorRepository])
void main() {
  late CalculateStringUseCase useCase;
  late MockCalculatorRepository mockRepository;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    useCase = CalculateStringUseCase(mockRepository);
  });

  group('CalculateStringUseCase', () {
    group('Empty string', () {
      test('should return 0 for empty string', () async {
        // Arrange
        const input = '';
        const expectedResult = CalculationResult(
          sum: 0,
          processedNumbers: [],
          usedDelimiters: [',', '\n'],
          originalInput: input,
        );

        when(mockRepository.validateInput(input)).thenReturn(true);
        when(mockRepository.add(input)).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.call(input);

        // Assert
        expect(result.sum, equals(0));
        expect(result.processedNumbers, isEmpty);
        expect(result.originalInput, equals(input));
        // verify if the validate input method was called with the input
        verify(mockRepository.validateInput(input));
        // verify if the input that is gone to the method is the input that we have passed
        verify(mockRepository.add(input));
      });
    });

    group('Single number', () {
      test('should return the number itself for single number input', () async {
        // Arrange
        const input = '1';
        const expectedResult = CalculationResult(
          sum: 1,
          processedNumbers: [1],
          usedDelimiters: [',', '\n'],
          originalInput: input,
        );

        when(mockRepository.validateInput(input)).thenReturn(true);
        when(mockRepository.add(input)).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.call(input);

        // Assert
        expect(result.sum, equals(1));
        expect(result.processedNumbers, equals([1]));
        expect(result.originalInput, equals(input));
        verify(mockRepository.validateInput(input));
        verify(mockRepository.add(input));
      });
    });

    group('Multiple numbers', () {
      test('should handle multiple numbers that are comma separated', () async {
        // Arrange
        const input = '1,2,3,4,5';
        const expectedResult = CalculationResult(
          sum: 15,
          processedNumbers: [1, 2, 3, 4, 5],
          usedDelimiters: [',', '\n'],
          originalInput: input,
        );

        when(mockRepository.validateInput(input)).thenReturn(true);
        when(mockRepository.add(input)).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.call(input);

        // Assert
        expect(result.sum, equals(15));
        expect(result.processedNumbers, equals([1, 2, 3, 4, 5]));
        verify(mockRepository.validateInput(input));
        verify(mockRepository.add(input));
      });
    });

    group('Error handling', () {
      test(
        'should throw CalculatorException for invalid input format',
        () async {
          // Arrange
          const input = 'invalid';

          when(mockRepository.validateInput(input)).thenReturn(false);

          // Act & Assert
          expect(
            () async => await useCase.call(input),
            throwsA(isA<CalculatorException>()),
          );
          verify(mockRepository.validateInput(input));
          verifyNever(mockRepository.add(any));
        },
      );

      test('should propagate repository exceptions', () async {
        // Arrange
        const input = '1,-2';
        final exception = CalculatorException.negativesNotAllowed([-2]);

        when(mockRepository.validateInput(input)).thenReturn(true);
        when(mockRepository.add(input)).thenThrow(exception);

        // Act & Assert
        expect(
          () async => await useCase.call(input),
          throwsA(isA<CalculatorException>()),
        );
        verify(mockRepository.validateInput(input));
        verify(mockRepository.add(input));
      });
    });
  });
}
