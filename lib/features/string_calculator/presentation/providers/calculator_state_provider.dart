import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/core/errors/calculator_exception.dart';
import 'package:string_calculator/features/string_calculator/domain/entities/calculation_result.dart';
import 'package:string_calculator/features/string_calculator/domain/usecases/calculate_string_use_case.dart';
import 'package:string_calculator/features/string_calculator/presentation/providers/calculator_providers.dart';

/// State class for calculator operations
class CalculatorState {
  final CalculationResult? result;
  final String? errorMessage;
  final bool isLoading;

  const CalculatorState({
    this.result,
    this.errorMessage,
    this.isLoading = false,
  });

  /// Creates a copy of this state with updated values
  CalculatorState copyWith({
    CalculationResult? result,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return CalculatorState(
      result: clearResult ? null : (result ?? this.result),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  /// Whether the current state has a successful result
  bool get hasResult => result != null && errorMessage == null;

  /// Whether the current state has an error
  bool get hasError => errorMessage != null;

  @override
  String toString() {
    return 'CalculatorState(hasResult: $hasResult, hasError: $hasError, isLoading: $isLoading)';
  }
}

/// Calculator State Notifier
///
/// Manages the state of the calculator including input, results, and errors
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  final CalculateStringUseCase _calculateStringUseCase;

  CalculatorNotifier(this._calculateStringUseCase)
    : super(const CalculatorState());

  /// Calculates the result for the current input
  Future<void> calculate(String input) async {
    if (input.isEmpty) {
      state = state.copyWith(clearResult: true, clearError: true);
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final result = await _calculateStringUseCase.call(
        Params(input: input),
      );

      state = state.copyWith(
        result: result,
        isLoading: false,
        clearError: true,
      );
    } on CalculatorException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoading: false,
        clearResult: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'An unexpected error occurred: $e',
        isLoading: false,
        clearResult: true,
      );
    }
  }

  /// Clears the current input and results
  void clear() {
    state = const CalculatorState();
  }

  /// Clears only the error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

/// Provider for Calculator State
///
/// This provides the state notifier that manages calculator operations
final calculatorStateProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
      final calculateStringUseCase = ref.read(calculateStringUseCaseProvider);
      return CalculatorNotifier(calculateStringUseCase);
    });
