import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_input.freezed.dart';

/// Represents the parsed input from the string calculator
/// Contains the extracted numbers and delimiters from the raw input
@freezed
abstract class ParsedInput with _$ParsedInput {
  const factory ParsedInput({
    /// The original raw input string
    required String rawInput,

    /// List of delimiters found in the input (default: [',', '\n'])
    required List<String> delimiters,

    /// The numbers part of the input (without delimiter declarations)
    required String numbersString,

    /// Whether custom delimiters were specified in the input
    @Default(false) bool hasCustomDelimiters,
  }) = _ParsedInput;

  const ParsedInput._();

  /// Factory constructor for creating ParsedInput with default delimiters
  factory ParsedInput.withDefaults(String rawInput) {
    return ParsedInput(
      rawInput: rawInput,
      delimiters: [',', '\n'],
      numbersString: rawInput,
      hasCustomDelimiters: false,
    );
  }

  /// Factory constructor for creating ParsedInput with custom delimiters
  factory ParsedInput.withCustomDelimiters({
    required String rawInput,
    required List<String> customDelimiters,
    required String numbersString,
  }) {
    return ParsedInput(
      rawInput: rawInput,
      delimiters: customDelimiters,
      numbersString: numbersString,
      hasCustomDelimiters: true,
    );
  }
}
