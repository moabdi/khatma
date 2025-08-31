import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_color_scheme.dart';
import 'app_text_theme.dart';

/// Main theme class following Material Design 3 guidelines
class AppTheme {
  AppTheme._();

  /// Design tokens
  static const double borderRadius = 12.0;
  static const double cardElevation = 1.0;
  static const double buttonHeight = 48.0;

  /// Create light theme
  static ThemeData get light => _buildTheme(
        colorScheme: AppColorScheme.light,
        brightness: Brightness.light,
      );

  /// Create dark theme
  static ThemeData get dark => _buildTheme(
        colorScheme: AppColorScheme.dark,
        brightness: Brightness.dark,
      );

  /// Build theme with given color scheme
  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final TextTheme textTheme = AppTextTheme.textTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // App Bar
      appBarTheme: _buildAppBarTheme(colorScheme, textTheme),

      // Cards
      cardTheme: _buildCardTheme(colorScheme),

      // Buttons
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme, textTheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme, textTheme),
      textButtonTheme: _buildTextButtonTheme(colorScheme, textTheme),

      // Input fields
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme, isDark),

      // List tiles
      listTileTheme: _buildListTileTheme(colorScheme, textTheme, isDark),

      // Other components
      chipTheme: _buildChipTheme(colorScheme, textTheme),
      dividerTheme: _buildDividerTheme(colorScheme),
      snackBarTheme: _buildSnackBarTheme(colorScheme, textTheme),
      floatingActionButtonTheme: _buildFABTheme(colorScheme),

      // System UI
      //systemUiOverlayStyle: _buildSystemUiOverlayStyle(isDark),
      applyElevationOverlayColor: true,
    );
  }

  /// App Bar Theme
  static AppBarTheme _buildAppBarTheme(
      ColorScheme colorScheme, TextTheme textTheme) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.headlineSmall,
      toolbarTextStyle: textTheme.bodyMedium,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  /// Card Theme
  static CardThemeData _buildCardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // color: colorScheme.onPrimary,
      //shadowColor: colorScheme.shadow,
      // Note: surfaceTintColor might need to be removed if not available in your Flutter version
      //surfaceTintColor: colorScheme.surfaceTint,
    );
  }

  /// Elevated Button Theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        minimumSize: const Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        elevation: 1,
      ),
    );
  }

  /// Outlined Button Theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        minimumSize: const Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(color: colorScheme.primary),
        textStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Text Button Theme
  static TextButtonThemeData _buildTextButtonTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: textTheme.bodyMedium,
      ),
    );
  }

  /// Input Decoration Theme
  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  /// List Tile Theme
  static ListTileThemeData _buildListTileTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isDark,
  ) {
    return ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // tileColor: colorScheme.onPrimaryFixed,
      selectedTileColor: colorScheme.primaryContainer.withAlpha(35),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      subtitleTextStyle: textTheme.titleSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      iconColor: colorScheme.primary,
    );
  }

  /// Chip Theme
  static ChipThemeData _buildChipTheme(
      ColorScheme colorScheme, TextTheme textTheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.secondaryContainer,
      disabledColor: colorScheme.surfaceContainer,
      labelStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Divider Theme
  static DividerThemeData _buildDividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(
      color: colorScheme.outline,
      thickness: .1,
      indent: .2,
      endIndent: .2,
    );
  }

  /// SnackBar Theme
  static SnackBarThemeData _buildSnackBarTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onInverseSurface,
      ),
      actionTextColor: colorScheme.inversePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  /// Floating Action Button Theme
  static FloatingActionButtonThemeData _buildFABTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  /// System UI Overlay Style
  static SystemUiOverlayStyle _buildSystemUiOverlayStyle(bool isDark) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );
  }
}

/// Extension for theme context access
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Semantic color accessors
  Color get successColor => colorScheme.brightness == Brightness.light
      ? AppColors.success
      : AppColors.success;

  Color get warningColor => colorScheme.brightness == Brightness.light
      ? AppColors.warning
      : AppColors.warning;

  Color get errorColor => colorScheme.error;
  Color get infoColor => AppColors.info;
}
