import '../../../../core/errors/calculator_exception.dart';
import '../entities/calculation_result.dart';
import '../repositories/calculator_repository.dart';

/// Use case for calculating sum of numbers from a string input
/// This is the main business logic entry point
class CalculateStringUseCase {
  final CalculatorRepository repository;

  const CalculateStringUseCase(this.repository);

  /// Calculates the sum of numbers in the input string
  /// Throws [CalculatorException] for any validation or parsing errors
  Future<CalculationResult> call(String input) async {
    // Input validation
    if (!repository.validateInput(input)) {
      throw CalculatorException.invalidFormat(input);
    }

    // Delegate to repository for the actual calculation
    return await repository.add(input);
  }
}
