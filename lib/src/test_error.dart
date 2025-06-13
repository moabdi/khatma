import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/exceptions/error_code.dart';
import 'package:khatma/src/exceptions/error_handler.dart';

/// Test widget to demonstrate handleUI usage with different error scenarios
class ErrorHandlerTestPage extends ConsumerStatefulWidget {
  const ErrorHandlerTestPage({super.key});

  @override
  ConsumerState<ErrorHandlerTestPage> createState() =>
      _ErrorHandlerTestPageState();
}

class _ErrorHandlerTestPageState extends ConsumerState<ErrorHandlerTestPage> {
  String _lastResult = 'No operation performed yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Handler Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Last Result: $_lastResult',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),

            // Success test
            ElevatedButton(
              onPressed: () => _testSuccess(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Test Success'),
            ),
            const SizedBox(height: 12),

            // Authentication error test
            ElevatedButton(
              onPressed: () => _testAuthError(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Test Auth Error (AUTH1)'),
            ),
            const SizedBox(height: 12),

            // Network error test
            ElevatedButton(
              onPressed: () => _testNetworkError(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Test Network Error (NET01)'),
            ),
            const SizedBox(height: 12),

            // Critical error test
            ElevatedButton(
              onPressed: () => _testCriticalError(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
              child: const Text('Test Critical Error (STR05)'),
            ),
            const SizedBox(height: 12),

            // Validation error test
            ElevatedButton(
              onPressed: () => _testValidationError(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Test Validation Error (VAL01)'),
            ),
            const SizedBox(height: 12),

            // Test with ErrorInfo (detailed error)
            ElevatedButton(
              onPressed: () => _testDetailedError(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Test Detailed Error (ErrorInfo)'),
            ),
            const SizedBox(height: 24),

            // Test error type checking
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _testErrorTypeChecking(),
                    child: const Text('Test Error Type Checking'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Test success scenario
  void _testSuccess() {
    final result =
        Result<String, ErrorInfo>.success('Operation completed successfully!');

    result.handleUI(
      context,
      onSuccess: () {
        setState(() {
          _lastResult = 'Success: ${result.dataOrNull}';
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Operation successful!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      },
      onError: () {
        setState(() {
          _lastResult = 'This should not be called for success';
        });
      },
    );
  }

  // Test authentication error
  void _testAuthError() {
    final result = Result<String, ErrorInfo>.failure(
        ErrorInfo(ErrorCode.authAnonymousNotAllowed, null));

    result.handleUI(
      context,
      onSuccess: () {
        setState(() {
          _lastResult = 'This should not be called for failure';
        });
      },
      onError: () {
        setState(() {
          _lastResult = 'Auth error handled';
        });
      },
      onRetry: () {
        setState(() {
          _lastResult = 'Retry button was pressed for AUTH1';
        });

        // You could navigate to login here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Redirecting to login...'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  // Test network error
  void _testNetworkError() {
    final result = Result<String, ErrorCode>.failure(ErrorCode.netBadRequest);

    result.handleUI(
      context,
      onSuccess: () {
        setState(() {
          _lastResult = 'This should not be called for failure';
        });
      },
      onError: () {
        setState(() {
          _lastResult = 'Network error handled - onError called';
        });
      },
      onRetry: () {
        setState(() {
          _lastResult = 'Retry attempted for network error';
        });

        // Simulate retry
        Future.delayed(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Retrying network operation...'),
              duration: Duration(seconds: 2),
            ),
          );
        });
      },
    );
  }

  // Test critical error (should show dialog)
  void _testCriticalError() {
    final result = Result<String, ErrorCode>.failure(ErrorCode.syncConflict);

    result.handleUI(
      context,
      onSuccess: () {},
      onError: () {
        setState(() {
          _lastResult = 'Critical error handled - should show dialog';
        });
      },
      onRetry: () {
        setState(() {
          _lastResult = 'Critical error retry attempted';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attempting to recover from critical error...'),
            duration: Duration(seconds: 3),
          ),
        );
      },
    );
  }

  // Test validation error
  void _testValidationError() {
    final result =
        Result<String, ErrorCode>.failure(ErrorCode.validationInvalidData);

    result.handleUI(
      context,
      onSuccess: () {
        setState(() {
          _lastResult = 'This should not be called for failure';
        });
      },
      onError: () {
        setState(() {
          _lastResult = 'Validation error handled';
        });
      },
    );
  }

  // Test with ErrorInfo (detailed error)
  void _testDetailedError() {
    final errorInfo = ErrorInfo(
        ErrorCode.netBadRequest, 'Connection timeout after 30 seconds');
    final result = Result<String, ErrorInfo>.failure(errorInfo);

    result.handleUI(
      context,
      onSuccess: () {
        setState(() {
          _lastResult = 'This should not be called for failure';
        });
      },
      onError: () {
        setState(() {
          _lastResult =
              'Detailed error handled: ${errorInfo.code} - ${errorInfo.details}';
        });
      },
      onRetry: () {
        setState(() {
          _lastResult = 'Retry attempted for detailed error';
        });
      },
    );
  }

  // Test error type checking
  void _testErrorTypeChecking() {
    final authError =
        Result<String, ErrorCode>.failure(ErrorCode.authAnonymousNotAllowed);
    final networkError =
        Result<String, ErrorCode>.failure(ErrorCode.netBadRequest);
    final syncError = Result<String, ErrorCode>.failure(ErrorCode.syncConflict);
    final successResult = Result<String, ErrorCode>.success("Success");

    final results = [
      'Auth Error - requiresAuth: ${authError.dataOrNull}',
      'Auth Error - isNetworkError: ${authError.isNetworkError}',
      'Network Error - requiresAuth: ${networkError.requiresAuth}',
      'Network Error - isNetworkError: ${networkError.isNetworkError}',
      'Sync Error - requiresAuth: ${syncError.requiresAuth}',
      'Sync Error - isNetworkError: ${syncError.isNetworkError}',
      'Success - requiresAuth: ${successResult.requiresAuth}',
      'Success - isNetworkError: ${successResult.isNetworkError}',
    ];

    setState(() {
      _lastResult = results.join('\n');
    });

    // Show in dialog for better readability
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error Type Checking Results'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: results
                .map((result) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(result, style: const TextStyle(fontSize: 12)),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Example of using handleUI in a real scenario (Khatma save)
class KhatmaSaveExample extends ConsumerWidget {
  final Khatma khatma;

  const KhatmaSaveExample({required this.khatma, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => _saveKhatma(context, ref),
      child: const Text('Save Khatma'),
    );
  }

  void _saveKhatma(BuildContext context, WidgetRef ref) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate the actual save operation
    final result = await _simulateKhatmaSave();

    // Hide loading
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Handle the result using handleUI
    result.handleUI(
      context,
      onSuccess: () {
        // Success handling
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Khatma saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Maybe navigate back or refresh data
        Navigator.of(context).pop(); // Go back to previous screen
      },
      onError: () {
        // Additional error handling if needed
        print('Error occurred while saving Khatma');
      },
      onRetry: () {
        // Retry the save operation
        _saveKhatma(context, ref);
      },
    );
  }

  // Simulate different save scenarios
  Future<Result<Khatma, ErrorCode>> _simulateKhatmaSave() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Randomly return different results for testing
    final scenarios = [
      Result<Khatma, ErrorCode>.success(khatma), // Success
      const Result<Khatma, ErrorCode>.failure(
          ErrorCode.netBadRequest), // Network error
      const Result<Khatma, ErrorCode>.failure(
          ErrorCode.authAnonymousNotAllowed), // Auth error
      const Result<Khatma, ErrorCode>.failure(
          ErrorCode.validationInvalidData), // Validation error
      const Result<Khatma, ErrorCode>.failure(
          ErrorCode.syncConflict), // Critical error
    ];

    return scenarios[DateTime.now().millisecond % scenarios.length];
  }
}

/// Quick test buttons for specific scenarios
class QuickTestButtons extends StatelessWidget {
  const QuickTestButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () =>
              _testQuickError(context, ErrorCode.authAnonymousNotAllowed),
          child: const Text('Quick Auth Error'),
        ),
        ElevatedButton(
          onPressed: () => _testQuickError(context, ErrorCode.netBadRequest),
          child: const Text('Quick Network Error'),
        ),
        ElevatedButton(
          onPressed: () => _testQuickSuccess(context),
          child: const Text('Quick Success'),
        ),
      ],
    );
  }

  void _testQuickError(BuildContext context, ErrorCode errorCode) {
    final result = Result<String, ErrorCode>.failure(errorCode);
    result.showErrorIfFailed(context);
  }

  void _testQuickSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quick success test!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Mock classes for the example
class Khatma {
  final String id;
  final String name;

  const Khatma({required this.id, required this.name});
}

// How to use the test page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handler Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ErrorHandlerTestPage(),
    );
  }
}
