import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/features/string_calculator/presentation/pages/calculator_page.dart';

void main() {
  runApp(const ProviderScope(child: StringCalculator()));
}

class StringCalculator extends StatelessWidget {
  const StringCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'String Calculator Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CalculatorPage(),
    );
  }
}
