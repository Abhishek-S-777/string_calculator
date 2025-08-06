import '../../../../core/errors/calculator_exception.dart';
import '../entities/calculation_result.dart';

/// Abstract repository defining the contract for string calculator operations
/// This follows the Dependency Inversion Principle - domain doesn't depend on data layer
abstract class CalculatorRepository {
  /// Main method that combines parsing and calculation
  /// This is the high-level operation that most use cases will call
  /// Throws [CalculatorException] on any errors
  Future<CalculationResult> add(String numbers);
}
