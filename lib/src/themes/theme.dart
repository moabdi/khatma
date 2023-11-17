import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static bool isLightTheme = true;
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
    Color primaryColor = primaryColors;
    Color secondaryColor = secondaryColors;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();

    TextTheme textTheme = _buildTextTheme(base.textTheme, "SFProText");
    return base.copyWith(
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: .2,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall!.copyWith(color: Colors.black),
        backgroundColor: Colors.white,
        iconTheme:
            base.iconTheme.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      visualDensity: VisualDensity.comfortable,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: primaryColors.withOpacity(0.2),
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      disabledColor: HexColor("F5F5F8"),
      buttonTheme: ButtonThemeData(
        height: 45,
        colorScheme: const ColorScheme.light().copyWith(
          primary: primaryColor,
          secondary: primaryColor,
        ),
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 20,
      ),
      textTheme: textTheme,
      primaryTextTheme: _buildTextTheme(base.textTheme, "SFProText"),
      platform: TargetPlatform.iOS,
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: primaryColor,
        brightness: ThemeData.light().brightness,
        labelStyle: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w100),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.blueGrey[50],
        thickness: 1,
        endIndent: 1,
        indent: 1,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      listTileTheme: ListTileThemeData(
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        selectedColor: primaryColor,
        tileColor: Colors.white,
        selectedTileColor: primaryColor.withOpacity(0.1),
        titleTextStyle:
            textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
        subtitleTextStyle:
            textTheme.bodyMedium!.copyWith(color: HexColor("#737A86")),
        titleAlignment: ListTileTitleAlignment.center,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(width: 1.5, color: primaryColor.withOpacity(.4)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryColors,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
            backgroundColor: primaryColors,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 58),
            shadowColor: primaryColors,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            textStyle: textTheme.bodyLarge),
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        backgroundColor: Colors.black,
        contentTextStyle: textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        actionTextColor: primaryColor,
        showCloseIcon: true,
      ),
      colorScheme: colorScheme.copyWith(background: HexColor("F5F5F8")),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyLarge,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(width: 1.5, color: primaryColor.withOpacity(.4)),
          ),
          labelStyle: textTheme.bodyMedium,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.grey.shade200,
        color: Colors.white,
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
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: HexColor("#1FAD85").withOpacity(0.5),
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.normal,
      ),
      textTheme: _buildTextTheme(base.textTheme, "Lato"),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, "Lato"),
      platform: TargetPlatform.iOS,
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade300,
        disabledColor: Colors.grey.shade300,
        selectedColor: primaryColor,
        secondarySelectedColor: Colors.grey.shade300,
        padding: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        secondaryLabelStyle: const TextStyle(),
        brightness: ThemeData.dark().brightness,
        labelStyle: const TextStyle(),
      ),
      dividerTheme: const DividerThemeData(
          color: Colors.blueGrey,
          thickness: .5,
          endIndent: .5,
          indent: .5,
          space: 0),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
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
