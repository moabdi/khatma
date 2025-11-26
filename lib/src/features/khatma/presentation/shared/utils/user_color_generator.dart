import 'package:flutter/material.dart';

/// Generates consistent colors for users based on their userId
/// Uses a deterministic hash to ensure the same user always gets the same color
class UserColorGenerator {
  UserColorGenerator._();

  // Palette of 20 soft, distinct colors that are visually pleasing and easy to distinguish
  static const _colors = [
    Color(0xFF8C9DEF), // Soft indigo
    Color(0xFF7BD37F), // Soft green
    Color(0xFFF2AD45), // Soft orange
    Color(0xFFBA68C8), // Soft purple
    Color(0xFF4DB6AC), // Soft teal
    Color(0xFF9575CD), // Soft deep purple
    Color(0xFFF06292), // Soft pink
    Color(0xFF4FC3F7), // Soft cyan
    Color(0xFFAED581), // Soft lime
    Color(0xFFFF8A65), // Soft deep orange
    Color(0xFF64B5F6), // Soft blue
    Color(0xFFDCE775), // Soft yellow green
    Color(0xFFA1887F), // Soft brown
    Color(0xFF90A4AE), // Soft blue grey
    Color(0xFFE57373), // Soft red
    Color(0xFFFFD54F), // Soft amber
    Color(0xFFEF5350), // Soft red variant
    Color(0xFFAB47BC), // Soft purple variant
    Color(0xFF26A69A), // Soft teal variant
    Color(0xFF42A5F5), // Soft blue variant
  ];

  /// Generate a consistent color for a user based on their userId
  ///
  /// Uses a simple hash function to deterministically map userId to a color.
  /// The same userId will always produce the same color.
  static Color getColorForUser(String userId) {
    // Use a simple but effective hash combining multiple operations
    // to reduce collision probability
    int hash = 0;
    for (int i = 0; i < userId.length; i++) {
      hash = ((hash << 5) - hash) + userId.codeUnitAt(i);
      hash = hash & hash; // Convert to 32-bit integer
    }

    // Take absolute value and modulo to get index
    final index = hash.abs() % _colors.length;
    return _colors[index];
  }
}
