import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/features/string_calculator/presentation/providers/calculator_state_provider.dart';

/// Widget for handling calculator input
///
/// Provides a text field for entering the string to be calculated
/// with real-time validation and examples
class CalculatorInputWidget extends ConsumerStatefulWidget {
  const CalculatorInputWidget({super.key});

  @override
  ConsumerState<CalculatorInputWidget> createState() =>
      CalculatorInputWidgetState();
}

class CalculatorInputWidgetState extends ConsumerState<CalculatorInputWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String inputText = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calculatorState = ref.watch(calculatorStateProvider);
    final calculatorNotifier = ref.read(calculatorStateProvider.notifier);

    // // Update controller when state changes
    // if (_controller.text != calculatorState.input) {
    //   _controller.text = calculatorState.input;
    //   _controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: _controller.text.length),
    //   );
    // }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: 4,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter numbers separated by commas or newlines...',
                border: const OutlineInputBorder(),
                focusedBorder: calculatorState.hasError
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[600]!),
                      )
                    : null,
                suffixIcon: inputText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            inputText = '';
                          });
                          _controller.clear();
                          _focusNode.unfocus();
                          calculatorNotifier.clear();
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Clear input',
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  inputText = value;
                });
              },

              style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Press Calculate button for the results',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Controls Section
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        inputText.isNotEmpty && !calculatorState.isLoading
                        ? () => calculatorNotifier.calculate(inputText)
                        : null,
                    icon: calculatorState.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.calculate),
                    label: Text(
                      calculatorState.isLoading
                          ? 'Calculating...'
                          : 'Calculate',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed:
                      inputText.isNotEmpty ||
                          calculatorState.hasResult ||
                          calculatorState.hasError
                      ? () {
                          setState(() {
                            inputText = '';
                          });
                          _controller.clear();
                          _focusNode.unfocus();
                          calculatorNotifier.clear();
                        }
                      : null,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    backgroundColor: Colors.grey[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setInputText(String text) {
    setState(() {
      inputText = text;
    });
    _controller.text = text;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
  }
}
