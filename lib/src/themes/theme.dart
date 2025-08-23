import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

class AppTheme {
  static Color primaryColors = HexColor("#00A862");
  static Color secondaryColors = HexColor("#C66628");

  // Keep your original shrine color scheme
  static const ColorScheme _shrineColorScheme = ColorScheme(
    primary: shrinePink100,
    primaryContainer: shrineBrown900,
    secondary: shrinePink50,
    secondaryContainer: shrineBrown900,
    surface: shrineSurfaceWhite,
    error: shrineErrorRed,
    onPrimary: shrineBrown900,
    onSecondary: shrineBrown900,
    onSurface: shrineBrown900,
    surfaceContainerHighest: shrineBrown900,
    onError: shrineSurfaceWhite,
    brightness: Brightness.light,
  );

  static const Color shrinePink50 = Color(0xFFFEEAE6);
  static const Color shrinePink100 = Color(0xFFFEDBD0);
  static const Color shrinePink300 = Color(0xFFFBB8AC);
  static const Color shrinePink400 = Color(0xFFEAA4A4);
  static const Color shrineBrown900 = Color(0xFF442B2D);
  static const Color shrineBrown600 = Color(0xFF7D4F52);
  static const Color shrineErrorRed = Color(0xFFC5032B);
  static const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
  static const Color shrineBackgroundWhite = Colors.white;

  // Helper methods for color variations
  static Color _darkenColor(Color color, double factor) {
    return Color.lerp(color, Colors.black, factor) ?? color;
  }

  static Color _lightenColor(Color color, double factor) {
    return Color.lerp(color, Colors.white, factor) ?? color;
  }

  // Light ColorScheme with your original colors
  static ColorScheme get lightColorScheme => const ColorScheme.light().copyWith(
        primary: primaryColors,
        secondary: secondaryColors,
      );

  // Dark ColorScheme with your original dark theme logic
  static ColorScheme get darkColorScheme => const ColorScheme.dark().copyWith(
        error: shrineErrorRed,
        primary: primaryColors,
        secondary: secondaryColors,
      );

  // Single theme method that accepts ColorScheme
  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
    final TextTheme textTheme = _buildTextTheme(base.textTheme);

    // Your original design tokens
    final BorderRadius borderRadius = BorderRadius.circular(10);
    final EdgeInsetsGeometry inputPadding = const EdgeInsets.all(15);

    // Your original input borders
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
          width: 1,
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
    );

    final OutlineInputBorder focusedInputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
          width: 1.5, color: colorScheme.primary.withAlpha(isDark ? 153 : 102)),
    );

    return base.copyWith(
      colorScheme: isDark
          ? darkColorScheme
          : _shrineColorScheme.copyWith(
              primary: primaryColors,
              secondary: secondaryColors,
            ),
      primaryColor: primaryColors,
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      canvasColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xfff5f5f5),
      appBarTheme: AppBarTheme(
        elevation: .2,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!
            .copyWith(color: isDark ? Colors.white : Colors.black),
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
        toolbarTextStyle: textTheme.bodyLarge
            ?.copyWith(color: isDark ? Colors.white : Colors.black),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      listTileTheme: ListTileThemeData(
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedColor: primaryColors,
        tileColor: isDark ? const Color(0xFF1F1F1F) : Colors.grey.shade50,
        selectedTileColor: primaryColors.withAlpha(51),
        titleTextStyle: isDark
            ? textTheme.titleMedium!.copyWith(color: Colors.white)
            : textTheme.titleMedium,
        subtitleTextStyle: textTheme.titleSmall!.copyWith(
            color: isDark ? HexColor("#737A86") : HexColor("#737A86")),
        titleAlignment: ListTileTitleAlignment.center,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: primaryColors,
        brightness: colorScheme.brightness,
        labelStyle: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w100),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.grey[700] : Colors.grey[200],
        thickness: 1,
        endIndent: 1,
        indent: 1,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        collapsedShape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1F1F1F) : Colors.grey[100],
        contentPadding: inputPadding,
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: inputBorder,
        focusedBorder: focusedInputBorder,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyLarge!
            .copyWith(color: isDark ? Colors.white : Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: isDark ? const Color(0xFF1F1F1F) : Colors.grey[100],
          contentPadding: inputPadding,
          hintStyle:
              TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
          enabledBorder: inputBorder,
          focusedBorder: focusedInputBorder,
          labelStyle: textTheme.bodyMedium!
              .copyWith(color: isDark ? Colors.white : Colors.black),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        shadowColor: isDark ? Colors.grey.shade900 : Colors.grey[300],
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
      ),
      textTheme: isDark
          ? textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white)
          : textTheme,
      primaryTextTheme: textTheme,
      buttonTheme: ButtonThemeData(
        height: 45,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: isDark ? Colors.black : primaryColors,
        elevation: 20,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          textStyle: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColors,
          side: BorderSide(color: primaryColors),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: primaryColors,
          foregroundColor: Colors.white,
          //side: BorderSide(color: primaryColors),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.titleMedium,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 10,
        backgroundColor: Colors.grey[900],
        contentTextStyle: textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        actionTextColor: primaryColors,
        showCloseIcon: true,
      ),
    );
  }

  // Keep your unused ListTileThemeData for reference
  ListTileThemeData appMaterialLightListTileThemeData = const ListTileThemeData(
    dense: false,
    style: ListTileStyle.list,
    selectedColor: Colors.amber,
    iconColor: Colors.red,
    textColor: Colors.blue,
    contentPadding: EdgeInsetsGeometry.infinity,
    tileColor: Colors.green,
    selectedTileColor: Colors.blueAccent,
    minLeadingWidth: 4,
    enableFeedback: true,
  );

  // Public theme methods
  static ThemeData lightTheme() => _buildTheme(lightColorScheme);
  static ThemeData darkTheme() => _buildTheme(darkColorScheme);

  // Method to create custom theme with different colors
  static ThemeData customTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Brightness brightness,
  }) {
    // Temporarily update the static colors
    final originalPrimary = primaryColors;
    final originalSecondary = secondaryColors;

    primaryColors = primaryColor;
    secondaryColors = secondaryColor;

    final ColorScheme customColorScheme =
        brightness == Brightness.dark ? darkColorScheme : lightColorScheme;

    final theme = _buildTheme(customColorScheme);

    // Restore original colors
    primaryColors = originalPrimary;
    secondaryColors = originalSecondary;

    return theme;
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    const largeFontFamily = 'SFProDisplay';
    const normalFontFamily = 'SFProText';

    return base.copyWith(
      displayLarge: const TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.w900,
        fontFamily: largeFontFamily,
        color: Colors.deepPurple,
      ),
      displayMedium: const TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w800,
        fontFamily: largeFontFamily,
        color: Colors.purple,
      ),
      displaySmall: const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        fontFamily: largeFontFamily,
        color: Colors.purple,
      ),
      headlineLarge: const TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
        fontFamily: normalFontFamily,
        color: Colors.black,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        fontFamily: largeFontFamily,
        color: Colors.black,
        wordSpacing: 0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        fontFamily: largeFontFamily,
        color: Colors.black,
      ),
      titleLarge: const TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w600,
        fontFamily: largeFontFamily,
        color: Colors.black,
        wordSpacing: 0.5,
      ),
      titleMedium: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: largeFontFamily,
        color: Colors.black,
        wordSpacing: 0.4,
      ),
      titleSmall: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: largeFontFamily,
        color: Colors.black,
        wordSpacing: 0.4,
      ),
      bodyLarge: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        fontFamily: normalFontFamily,
        color: Colors.black,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: normalFontFamily,
        color: Colors.black,
      ),
      bodySmall: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        fontFamily: normalFontFamily,
        color: Colors.black,
      ),
      labelLarge: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        fontFamily: normalFontFamily,
        color: Colors.black,
      ),
      labelMedium: const TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w400,
        fontFamily: normalFontFamily,
      ),
      labelSmall: const TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        fontFamily: normalFontFamily,
        wordSpacing: 0.5,
      ),
    );
  }
}

extension CustomColorScheme on ColorScheme {
  Color get backcolor => brightness == Brightness.light
      ? const Color(0xFFe0e0e0)
      : const Color(0xFF424242);
  Color get success => brightness == Brightness.light
      ? const Color(0xFF28a745)
      : const Color(0xFF007E33);
  Color get warning => brightness == Brightness.light
      ? const Color(0xFFffc107)
      : const Color(0xFFFF8800);
  Color get danger => brightness == Brightness.light
      ? const Color(0xFFdc3545)
      : const Color(0xFFCC0000);
  Color get info => brightness == Brightness.light
      ? const Color(0xFFE8F2FD)
      : const Color(0xFF0099CC);
  Color get error => brightness == Brightness.light
      ? const Color(0xFFdc3545)
      : const Color(0xFFCC0000);
}

/// Extension pour faciliter l'accès aux thèmes via le contexte
extension ThemeContext on BuildContext {
  /// Raccourci pour accéder aux thèmes
  /// Usage: context.theme.myThemeKey
  ThemeData get theme => Theme.of(this);

  /// Raccourci pour accéder au text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
