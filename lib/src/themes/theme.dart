import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static bool isLightTheme = false;
  static Color primaryColors = HexColor("#00A862");
  // static Color primaryColors = Colors.blue;
  static Color secondaryColors = HexColor("#C66628");
  // ignore: unused_field
  static const ColorScheme _shrineColorScheme = ColorScheme(
    primary: shrinePink100,
    primaryContainer: shrineBrown900,
    secondary: shrinePink50,
    secondaryContainer: shrineBrown900,
    surface: shrineSurfaceWhite,
    background: shrineBackgroundWhite,
    error: shrineErrorRed,
    onPrimary: shrineBrown900,
    onSecondary: shrineBrown900,
    onSurface: shrineBrown900,
    onBackground: shrineBrown900,
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

  static ThemeData getTheme() {
    if (isLightTheme) {
      return newLightTheme();
    } else {
      return newDarkTheme();
    }
  }

  static ThemeData newLightTheme() {
    final Color primaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColors,
    );
    final ThemeData base = ThemeData.light();

    final textTheme = _buildTextTheme(base.textTheme, "SFProText");

    // Centralized shape and border values
    final BorderRadius borderRadius = BorderRadius.circular(10);
    final EdgeInsetsGeometry inputPadding = const EdgeInsets.all(15);

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
    );

    final OutlineInputBorder focusedInputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(width: 1.5, color: primaryColor.withOpacity(.4)),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: const Color(0xfff5f5f5),
      appBarTheme: AppBarTheme(
        elevation: .2,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!.copyWith(color: Colors.black),
        backgroundColor: Colors.white,
        toolbarTextStyle: textTheme.bodyLarge?.copyWith(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      listTileTheme: ListTileThemeData(
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedColor: primaryColor,
        tileColor: Colors.white,
        selectedTileColor: primaryColor.withOpacity(0.2),
        titleTextStyle: textTheme.titleSmall,
        subtitleTextStyle:
            textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
        titleAlignment: ListTileTitleAlignment.center,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: primaryColor,
        brightness: Brightness.light,
        labelStyle: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w100),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[200],
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
        fillColor: Colors.grey[100],
        contentPadding: inputPadding,
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: inputBorder,
        focusedBorder: focusedInputBorder,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyLarge!.copyWith(color: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: inputPadding,
          hintStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: inputBorder,
          focusedBorder: focusedInputBorder,
          labelStyle: textTheme.bodyMedium!.copyWith(color: Colors.black),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        shadowColor: Colors.grey[100],
        color: Colors.white,
      ),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      buttonTheme: ButtonThemeData(
        height: 45,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 20,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          textStyle:
              textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(double.infinity, 40),
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 58),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
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
        actionTextColor: primaryColor,
        showCloseIcon: true,
      ),
    );
  }

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

  static ThemeData newDarkTheme() {
    Color primaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColors,
    );
    final ThemeData base = ThemeData.dark();

    TextTheme textTheme = _buildTextTheme(base.textTheme, "SFProText");

    return base.copyWith(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF121212),
      canvasColor: const Color(0xFF1E1E1E),
      appBarTheme: AppBarTheme(
        elevation: .2,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!.copyWith(color: Colors.white),
        backgroundColor: const Color(0xFF1F1F1F),
        toolbarTextStyle: textTheme.bodyLarge?.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      listTileTheme: ListTileThemeData(
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        selectedColor: primaryColor,
        tileColor: const Color(0xFF1F1F1F),
        selectedTileColor: primaryColor.withOpacity(0.2),
        titleTextStyle: textTheme.titleSmall!.copyWith(color: Colors.white),
        subtitleTextStyle:
            textTheme.bodyMedium!.copyWith(color: Colors.grey[400]),
        titleAlignment: ListTileTitleAlignment.center,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: primaryColor,
        brightness: Brightness.dark,
        labelStyle: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w100),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[700],
        thickness: 1,
        endIndent: 1,
        indent: 1,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding: const EdgeInsets.all(15),
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(width: 1.5, color: primaryColor.withOpacity(.6)),
        ),
      ),
      textTheme:
          textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      primaryTextTheme: textTheme,
      buttonTheme: ButtonThemeData(
        height: 45,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 20,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(double.infinity, 40),
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 58),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          textStyle: textTheme.titleMedium,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        backgroundColor: Colors.grey[900],
        contentTextStyle: textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        actionTextColor: primaryColor,
        showCloseIcon: true,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyLarge!.copyWith(color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(width: 1.5, color: primaryColor.withOpacity(.4)),
          ),
          labelStyle: textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.grey.shade900,
        color: const Color(0xFF1E1E1E),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, String pFontFamily) {
    pFontFamily = 'SFProDisplay';
    return base.copyWith(
      displayLarge: const TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'SFProDisplay',
        color: Colors.deepPurple,
      ),
      displayMedium: const TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
        fontFamily: 'SFProDisplay',
        color: Colors.purple,
      ),
      displaySmall: const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFProDisplay',
        color: Colors.purple,
      ),
      headlineLarge: const TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFProText',
        color: Colors.black,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFProDisplay',
        color: Colors.black,
        wordSpacing: 0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFProDisplay',
        color: Colors.black,
      ),
      titleLarge: const TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'SFProDisplay',
        color: Colors.black,
        wordSpacing: 0.5,
      ),
      titleMedium: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'SFProDisplay',
        color: Colors.black,
        wordSpacing: 0.5,
      ),
      titleSmall: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontFamily: 'SFProDisplay',
        color: Colors.black,
        wordSpacing: 0.4,
      ),
      bodyLarge: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFProText',
        color: Colors.black,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'SFProText',
        color: Colors.black,
      ),
      bodySmall: const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'SFProText',
        color: Colors.black,
      ),
      labelLarge: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFProText',
        color: Colors.black,
      ),
      labelMedium: const TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'SFProText',
      ),
      labelSmall: const TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'SFProText',
        wordSpacing: 0.5,
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension ColorToHex on Color {
  String toHex() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

extension StringToColor on String {
  Color toColor() => HexColor(this);
}

extension CustomColorScheme on ColorScheme {
  Color get backcolor =>
      AppTheme.isLightTheme ? const Color(0xFFe0e0e0) : const Color(0xFE424242);
  Color get success =>
      AppTheme.isLightTheme ? const Color(0xFF28a745) : const Color(0xFF007E33);
  Color get warning =>
      AppTheme.isLightTheme ? const Color(0xFFffc107) : const Color(0xFFFF8800);
  Color get danger =>
      AppTheme.isLightTheme ? const Color(0xFFdc3545) : const Color(0xFFCC0000);
  Color get info =>
      AppTheme.isLightTheme ? const Color(0xFFE8F2FD) : const Color(0xFF0099CC);
}
