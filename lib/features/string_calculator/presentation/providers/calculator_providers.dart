import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/features/string_calculator/data/repositories/calculator_repository_impl.dart';
import 'package:string_calculator/features/string_calculator/domain/repositories/calculator_repository.dart';
import 'package:string_calculator/features/string_calculator/domain/usecases/calculate_string_use_case.dart';

/// Provider for Calculator Repository
///
/// This provides the concrete implementation of the repository
/// that handles all string calculator business logic
final calculatorRepositoryProvider = Provider<CalculatorRepository>((ref) {
  return CalculatorRepositoryImpl();
});

/// Provider for Calculate String Use Case
///
/// This provides the use case that orchestrates the string calculation
/// Depends on the calculator repository
final calculateStringUseCaseProvider = Provider<CalculateStringUseCase>((ref) {
  final repository = ref.read(calculatorRepositoryProvider);
  return CalculateStringUseCase(repository);
});
