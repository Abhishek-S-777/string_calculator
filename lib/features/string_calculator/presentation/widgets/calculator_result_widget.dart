import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/features/string_calculator/presentation/providers/calculator_state_provider.dart';

/// Widget for displaying calculation results
///
/// Shows the sum, processed numbers, delimiters used, and other metadata
/// from the calculation result
class CalculatorResultWidget extends ConsumerWidget {
  const CalculatorResultWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorStateProvider);

    if (!calculatorState.hasResult && !calculatorState.hasError) {
      return _buildPlaceholder(context);
    }

    if (calculatorState.hasError) {
      return _buildErrorDisplay(context, calculatorState.errorMessage!);
    }

    return _buildResultDisplay(context, calculatorState);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.calculate_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Results will appear here',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDisplay(BuildContext context, String errorMessage) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red[600]),
                const SizedBox(width: 8),
                Text(
                  'Error',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.red[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: errorMessage));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error message copied to clipboard'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 20),
                    tooltip: 'Copy error message',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDisplay(BuildContext context, CalculatorState state) {
    final result = state.result!;

    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green[600]),
                const SizedBox(width: 8),
                Text(
                  'Result',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();

                    final resultText =
                        '''
Sum: ${result.sum}
Input: ${result.originalInput}
Numbers: ${result.processedNumbers.join(', ')}
Delimiters: ${result.usedDelimiters.join(', ')}
''';
                    Clipboard.setData(ClipboardData(text: resultText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Result copied to clipboard'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copy result',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Sum Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sum',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${result.sum}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Details Section
            _buildDetailItem(
              context,
              'Original Input',
              result.originalInput.isEmpty ? '(empty)' : result.originalInput,
              Icons.input,
            ),

            const SizedBox(height: 12),

            _buildDetailItem(
              context,
              'Processed Numbers',
              result.processedNumbers.isEmpty
                  ? '(none)'
                  : result.processedNumbers.join(', '),
              Icons.numbers,
            ),

            const SizedBox(height: 12),

            _buildDetailItem(
              context,
              'Delimiters Used',
              result.usedDelimiters
                  .map((d) => d == '\n' ? '\\n' : d)
                  .join(', '),
              Icons.settings_input_composite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
