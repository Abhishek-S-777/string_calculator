import 'package:string_calculator/core/errors/calculator_exception.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/calculation_result.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/parsed_input.dart';
import 'package:string_calculator/features/string_calculator/domain/repositories/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  static const List<String> _defaultDelimiters = [',', '\n'];
  static const String _customDelimiterPrefix = '//';

  @override
  Future<CalculationResult> add(String numbers) async {
    try {
      if (!_validateInput(numbers)) {
        throw CalculatorException.invalidFormat(numbers);
      }

      // Parse the input to extract delimiters and numbers
      final parsedInput = await _parseInput(numbers);

      // _calculate the result
      final result = await _calculate(parsedInput);

      return result;
    } catch (e) {
      if (e is CalculatorException) {
        rethrow;
      }
      throw CalculatorException.parsingError(numbers, e.toString());
    }
  }

  Future<CalculationResult> _calculate(ParsedInput parsedInput) async {
    try {
      // Extract numbers from the parsed input
      final allNumbers = _extractNumbers(parsedInput);

      // Validate numbers (check for negatives)
      _validateNumbers(allNumbers);

      // _calculate sum
      final sum = allNumbers.fold<int>(
        0,
        (previous, current) => previous + current,
      );

      return CalculationResult(
        sum: sum,
        processedNumbers: allNumbers,
        usedDelimiters: parsedInput.delimiters,
        originalInput: parsedInput.rawInput,
      );
    } catch (e) {
      if (e is CalculatorException) {
        rethrow;
      }
      throw CalculatorException.parsingError(
        parsedInput.rawInput,
        e.toString(),
      );
    }
  }

  List<int> _extractNumbers(ParsedInput parsedInput) {
    if (parsedInput.numbersString.isEmpty) {
      return [];
    }

    try {
      // Create a regex pattern from all delimiters
      final escapedDelimiters = parsedInput.delimiters
          .map((delimiter) => RegExp.escape(delimiter))
          .join('|');

      final pattern = RegExp('($escapedDelimiters)+');

      // Split by delimiters and parse numbers
      final numberStrings = parsedInput.numbersString
          .split(pattern)
          .where(
            (str) => str.isNotEmpty && !parsedInput.delimiters.contains(str),
          )
          .toList();

      final numbers = <int>[];
      for (final numberStr in numberStrings) {
        final trimmed = numberStr.trim();
        if (trimmed.isNotEmpty) {
          final number = int.tryParse(trimmed);
          if (number == null) {
            throw CalculatorException.invalidFormat(
              parsedInput.rawInput,
              'Cannot parse "$trimmed" as a number',
            );
          }
          numbers.add(number);
        }
      }

      return numbers;
    } catch (e) {
      if (e is CalculatorException) {
        rethrow;
      }
      throw CalculatorException.parsingError(
        parsedInput.rawInput,
        'Failed to extract numbers: $e',
      );
    }
  }

  Future<ParsedInput> _parseInput(String input) async {
    try {
      if (input.isEmpty) {
        return ParsedInput(
          rawInput: input,
          numbersString: '',
          delimiters: _defaultDelimiters,
        );
      }

      // Check for custom delimiter format: //[delimiter]\n[numbers]
      if (input.startsWith(_customDelimiterPrefix)) {
        return _parseCustomDelimiterInput(input);
      }

      // Default case: use default delimiters
      return ParsedInput(
        rawInput: input,
        numbersString: input,
        delimiters: _defaultDelimiters,
      );
    } catch (e) {
      if (e is CalculatorException) {
        rethrow;
      }
      throw CalculatorException.parsingError(input, e.toString());
    }
  }

  bool _validateInput(String input) {
    try {
      // Basic validation - check if input can be parsed
      if (input.isEmpty) return true;

      // Check for basic format issues
      if (input.contains(',,') || input.contains('\n\n')) {
        return false;
      }

      // Check custom delimiter format
      if (input.startsWith(_customDelimiterPrefix)) {
        final newlineIndex = input.indexOf('\n');
        if (newlineIndex == -1 ||
            newlineIndex <= _customDelimiterPrefix.length) {
          return false;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  void _validateNumbers(List<int> numbers) {
    final negativeNumbers = numbers.where((n) => n < 0).toList();
    if (negativeNumbers.isNotEmpty) {
      throw CalculatorException.negativesNotAllowed(negativeNumbers);
    }
  }

  /// Parses input with custom delimiter format: //[delimiter]\n[numbers]
  ParsedInput _parseCustomDelimiterInput(String input) {
    final newlineIndex = input.indexOf('\n');
    if (newlineIndex == -1) {
      throw CalculatorException.invalidFormat(
        input,
        'Custom delimiter format must contain newline after delimiter definition',
      );
    }

    final delimiterPart = input.substring(
      _customDelimiterPrefix.length,
      newlineIndex,
    );
    final numbersString = input.substring(newlineIndex + 1);

    final delimiters = _parseDelimiters(delimiterPart);

    // Include default delimiters as well
    final allDelimiters = [..._defaultDelimiters, ...delimiters];

    return ParsedInput(
      rawInput: input,
      numbersString: numbersString,
      delimiters: allDelimiters,
    );
  }

  /// Parses delimiter part to extract single or multiple delimiters
  List<String> _parseDelimiters(String delimiterPart) {
    if (delimiterPart.isEmpty) {
      throw CalculatorException.invalidDelimiter('Empty delimiter definition');
    }

    // Handle multiple delimiters: [delim1][delim2][delim3]
    if (delimiterPart.startsWith('[')) {
      return _parseMultipleDelimiters(delimiterPart);
    }

    // Single character delimiter
    if (delimiterPart.length == 1) {
      return [delimiterPart];
    }

    // Handle single multi-character delimiter without brackets
    return [delimiterPart];
  }

  /// Parses multiple delimiters in format [delim1][delim2][delim3]
  List<String> _parseMultipleDelimiters(String delimiterPart) {
    final delimiters = <String>[];
    var currentPos = 0;

    while (currentPos < delimiterPart.length) {
      if (delimiterPart[currentPos] != '[') {
        throw CalculatorException.invalidDelimiter(
          'Multiple delimiters must be enclosed in brackets: $delimiterPart',
        );
      }

      final endBracket = delimiterPart.indexOf(']', currentPos);
      if (endBracket == -1) {
        throw CalculatorException.invalidDelimiter(
          'Unclosed bracket in delimiter definition: $delimiterPart',
        );
      }

      final delimiter = delimiterPart.substring(currentPos + 1, endBracket);
      if (delimiter.isEmpty) {
        throw CalculatorException.invalidDelimiter(
          'Empty delimiter in brackets: $delimiterPart',
        );
      }

      delimiters.add(delimiter);
      currentPos = endBracket + 1;
    }

    if (delimiters.isEmpty) {
      throw CalculatorException.invalidDelimiter(
        'No delimiters found in: $delimiterPart',
      );
    }

    return delimiters;
  }
}
