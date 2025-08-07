import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_calculator/core/theme/app_theme.dart';
import 'package:string_calculator/core/theme/theme_provider.dart';
import 'package:string_calculator/features/string_calculator/presentation/pages/calculator_page.dart';

void main() {
  runApp(const ProviderScope(child: StringCalculator()));
}

class StringCalculator extends ConsumerWidget {
  const StringCalculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'String Calculator Pro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: CalculatorPage(),
    );
  }
}
