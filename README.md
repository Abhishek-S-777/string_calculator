# String Calc Pro - TDD

A professional Flutter application demonstrating **Test-Driven Development (TDD)** principles through the classic String Calculator kata. Built with Clean Architecture and modern Flutter practices.

Go to [problem statement](https://osherove.com/tdd-kata-1/)

## 🎯 Project Overview

This project showcases enterprise-level Flutter development with:

- **Clean Architecture** (Domain → Data → Presentation layers)
- **Test-Driven Development** with Red-Green-Refactor cycles
- **Riverpod** for reactive state management
- **Material 3** design with adaptive dark/light themes
- **Comprehensive error handling** with custom exceptions

## 📱 Demo

https://github.com/user-attachments/assets/9cadce24-52eb-4778-8db1-eef853fef5e6

## 🏗️ Architecture & Folder Structure

```dart
lib/
├── core/                           
│   ├── theme/                      
│   │   ├── app_theme.dart         
│   │   └── theme_provider.dart    
│   ├── errors/
│   │   └── calculator_exception.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│
├── features/                       
│   └── string_calculator/         
│       ├── domain/                 
│       │   ├── entities/          
│       │   │   ├── calculation_result.dart
│       │   │   └── parsed_input.dart
│       │   ├── repositories/       
│       │   │   └── calculator_repository.dart
│       │   └── usecases/          
│       │       └── calculate_string_use_case.dart
│       │
│       ├── data/                   
│       │   ├── models/            
│       │   │   ├── calculation_result_model.dart
│       │   └── repositories/       
│       │       └── calculator_repository_impl.dart
│       │
│       └── presentation/           
│           ├── pages/             
│           │   └── calculator_page.dart
│           ├── widgets/           
│           │   ├── calculator_input_widget.dart
│           │   ├── calculator_result_widget.dart
│           └── providers/         
│               ├── calculator_providers.dart
│               └── calculator_state_provider.dart
│
└── main.dart                       
```

## 🔄 TDD Development Process

### Phase 1: Domain-First Design (RED)

1. **Created core entities** (`CalculationResult`, `CalculatorConfig`, `ParsedInput`)
2. **Defined repository contract** with clear method signatures
3. **Built use case** with proper parameter validation
4. **Wrote failing tests** for all domain logic

### Phase 2: Implementation (GREEN)

1. **Implemented repository** with string parsing logic
2. **Added comprehensive error handling** with custom exceptions
3. **Created data models** for future persistence needs
4. **Made all tests pass** with minimal implementation

### Phase 3: Refactoring & Enhancement (REFACTOR)

1. **Optimized parsing algorithms** for complex delimiters
2. **Enhanced error messages** with contextual information
3. **Added edge case handling** (empty strings, large numbers, etc.)
4. **Improved test coverage** to 100%

### Phase 4: Presentation Layer

1. **Built reactive UI** with Riverpod state management
2. **Created reusable widgets** following single responsibility
3. **Implemented responsive design** with proper keyboard handling
4. **Added theme system** with dark/light mode support

## ✨ Features

### String Calculator Capabilities

- ✅ **Basic arithmetic**: Comma and newline separated numbers
- ✅ **Custom delimiters**: Single character (`//;\n1;2;3`)
- ✅ **Multi-character delimiters**: Bracketed format (`//[***]\n1***2***3`)
- ✅ **Multiple delimiters**: Combined patterns (`//[*][%]\n1*2%3`)
- ✅ **Negative validation**: Throws descriptive errors for negatives

### UI/UX Features

- 🎨 **Adaptive theming**: Material 3 light/dark modes
- 📱 **Responsive design**: Optimized for various screen sizes
- ⌨️ **Smart keyboard handling**: No overflow, proper focus management
- 📋 **Copy functionality**: Results and errors copyable to clipboard
- 🎯 **Interactive examples**: Tap to try predefined inputs
- ⚡ **Haptic feedback**: Enhanced user interaction experience

## 🧪 Testing Philosophy

Following **strict TDD methodology**:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

**Test Categories:**

- **Unit Tests**: Repository business logic (100% coverage)
- **Use Case Tests**: Parameter validation and error handling

## 🛠️ Technical Highlights

### Clean Architecture Benefits

- **Separation of Concerns**: Domain logic independent of UI
- **Dependency Inversion**: Abstractions over implementations
- **Testability**: Easy mocking and isolated testing
- **Maintainability**: Clear boundaries and responsibilities

### State Management Pattern

```dart
// Reactive state with Riverpod
final calculatorStateProvider = StateNotifierProvider<CalculatorNotifier, CalculatorState>(
  (ref) => CalculatorNotifier(ref.read(calculateStringUseCaseProvider))
);
```

### Error Handling Strategy

```dart
// Custom exceptions with context
throw CalculatorException.negativesNotAllowed(negatives);
// Result in user-friendly UI messages
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.8.1+
- Dart 3.0+

### Installation

```bash
# Clone the repository
git clone https://github.com/Abhishek-S-777/string_calculator.git

# Navigate to project
cd string_calculator

# Install dependencies
flutter pub get

# Run tests
flutter test

# Launch application
flutter run
```

---

**Built with ❤️ using Flutter & TDD principles**
