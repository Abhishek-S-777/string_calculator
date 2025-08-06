import 'package:string_calculator/core/usecases/usecase.dart';

import '../../../../core/errors/calculator_exception.dart';
import '../entities/calculation_result.dart';
import '../repositories/calculator_repository.dart';

/// Use case for calculating sum of numbers from a string input
/// This is the main business logic entry point
class CalculateStringUseCase implements UseCase<CalculationResult, Params> {
  final CalculatorRepository repository;

  const CalculateStringUseCase(this.repository);

  /// Calculates the sum of numbers in the input string
  /// Throws [CalculatorException] for any validation or parsing errors
  @override
  Future<CalculationResult> call(Params params) async {
    // Input validation
    if (!repository.validateInput(params.input)) {
      throw CalculatorException.invalidFormat(params.input);
    }

    // Delegate to repository for the actual calculation
    return await repository.add(params.input);
  }
}

class Params {
  final String input;

  Params({required this.input});
}
