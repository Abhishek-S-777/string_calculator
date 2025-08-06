import '../../../../core/errors/calculator_exception.dart';
import '../entities/calculation_result.dart';
import '../entities/parsed_input.dart';

/// Abstract repository defining the contract for string calculator operations
/// This follows the Dependency Inversion Principle - domain doesn't depend on data layer
abstract class CalculatorRepository {
  /// Parses the raw input string to extract delimiters and numbers
  /// Throws [CalculatorException] on parsing errors
  Future<ParsedInput> parseInput(String input);

  /// Performs the calculation on the parsed input
  /// Throws [CalculatorException] on calculation errors
  Future<CalculationResult> calculate(ParsedInput parsedInput);

  /// Main method that combines parsing and calculation
  /// This is the high-level operation that most use cases will call
  /// Throws [CalculatorException] on any errors
  Future<CalculationResult> add(String numbers);

  /// Validates if the input format is correct
  /// Returns true if valid, false otherwise
  bool validateInput(String input);

  /// Extracts numbers from the parsed input string using the provided delimiters
  /// Throws [CalculatorException] if parsing fails
  List<int> extractNumbers(ParsedInput parsedInput);

  /// Validates that no negative numbers are present (if not allowed by config)
  /// Throws [CalculatorException] with negative numbers listed if validation fails
  void validateNumbers(List<int> numbers);
}
