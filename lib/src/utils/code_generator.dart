import 'dart:math';

/// Generates a secure alphanumeric code with guaranteed mix of letters and numbers
class CodeGenerator {
  static final _random = Random.secure();
  static const _letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _numbers = '0123456789';
  static const _alphanumeric = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  /// Generates a 6-character alphanumeric code that always contains
  /// both letters and numbers (never only letters or only numbers)
  static String generate6CharCode() {
    String code;
    int attempts = 0;
    const maxAttempts = 100; // Safety limit

    do {
      code = _generateRandomCode(6);
      attempts++;

      if (attempts > maxAttempts) {
        // Fallback: manually ensure mix by placing at least one letter and one number
        return _generateGuaranteedMixCode(6);
      }
    } while (!_hasLettersAndNumbers(code));

    return code;
  }

  /// Generates a random alphanumeric code of specified length
  static String _generateRandomCode(int length) {
    return List.generate(
      length,
      (_) => _alphanumeric[_random.nextInt(_alphanumeric.length)],
    ).join();
  }

  /// Generates a code with guaranteed mix of letters and numbers
  /// This is used as a fallback to ensure we always get a valid code
  static String _generateGuaranteedMixCode(int length) {
    if (length < 2) {
      throw ArgumentError('Length must be at least 2 to guarantee mix');
    }

    final result = <String>[];

    // Ensure at least one letter
    result.add(_letters[_random.nextInt(_letters.length)]);

    // Ensure at least one number
    result.add(_numbers[_random.nextInt(_numbers.length)]);

    // Fill the rest randomly
    for (int i = 2; i < length; i++) {
      result.add(_alphanumeric[_random.nextInt(_alphanumeric.length)]);
    }

    // Shuffle to randomize positions
    result.shuffle(_random);

    return result.join();
  }

  /// Checks if the code contains both letters and numbers
  static bool _hasLettersAndNumbers(String code) {
    final hasLetter = code.split('').any((c) => _letters.contains(c));
    final hasNumber = code.split('').any((c) => _numbers.contains(c));
    return hasLetter && hasNumber;
  }

  /// Generates a code of custom length with guaranteed letter/number mix
  static String generateCode(int length) {
    if (length < 2) {
      throw ArgumentError('Length must be at least 2 to guarantee both letters and numbers');
    }

    String code;
    int attempts = 0;
    const maxAttempts = 100;

    do {
      code = _generateRandomCode(length);
      attempts++;

      if (attempts > maxAttempts) {
        return _generateGuaranteedMixCode(length);
      }
    } while (!_hasLettersAndNumbers(code));

    return code;
  }
}
