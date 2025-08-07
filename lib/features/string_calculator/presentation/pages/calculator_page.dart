import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/features/string_calculator/presentation/providers/calculator_state_provider.dart';
import 'package:string_calculator/features/string_calculator/presentation/widgets/calculator_input_widget.dart';
import 'package:string_calculator/features/string_calculator/presentation/widgets/calculator_result_widget.dart';

/// Main Calculator Page
///
/// This is the primary screen for the String Calculator application
/// following Clean Architecture principles with Riverpod state management
class CalculatorPage extends ConsumerWidget {
  CalculatorPage({super.key});

  // GlobalKey to access the input widget
  final GlobalKey<CalculatorInputWidgetState> _inputKey =
      GlobalKey<CalculatorInputWidgetState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorStateProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('String Calculator Pro'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => ref.read(calculatorStateProvider.notifier).clear(),
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Fixed content at top - reduced padding and compact layout
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Input Section
                CalculatorInputWidget(key: _inputKey),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Scrollable content below - takes remaining space
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Result Section
                  const CalculatorResultWidget(),
                  const SizedBox(height: 16),
                  // Examples Section
                  if (!calculatorState.hasResult &&
                      !calculatorState.hasError) ...[
                    _buildExamplesSection(context, ref),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Examples:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._getExamples().map(
              (example) => _buildExampleItem(
                context,
                ref,
                example['input']!,
                example['description']!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleItem(
    BuildContext context,
    WidgetRef ref,
    String input,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                // Use the GlobalKey to call the public method
                _inputKey.currentState?.setInputText(input);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getExamples() {
    return [
      {'input': '1,2,3', 'description': 'Basic comma-separated numbers'},
      {'input': '1\n2,3', 'description': 'Mixed comma and newline delimiters'},
      {
        'input': '//;\n1;2;3',
        'description': 'Custom single character delimiter',
      },
      {
        'input': '//[***]\n1***2***3',
        'description': 'Custom multi-character delimiter',
      },
      {'input': '//[*][%]\n1*2%3', 'description': 'Multiple custom delimiters'},
      {'input': '//[*][%]\nabh*12', 'description': 'Wrong input'},
    ];
  }
}
