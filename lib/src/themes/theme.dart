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

    TextTheme textTheme = _buildTextTheme(base.textTheme, "Lato");
    return base.copyWith(
      useMaterial3: true,
      brightness: Brightness.light,
      backgroundColor: HexColor("F5F5F8"),
      appBarTheme: AppBarTheme(
        elevation: .2,
        centerTitle: false,
        titleTextStyle: textTheme.headline5!.copyWith(color: Colors.black),
        backgroundColor: Colors.white,
        iconTheme:
            base.iconTheme.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      bottomAppBarColor: const Color(0xFFF7FCFD),
      visualDensity: VisualDensity.comfortable,
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: primaryColors.withOpacity(0.2),
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      errorColor: const Color(0xFFB00020),
      disabledColor: HexColor("F5F5F8"),
      buttonTheme: ButtonThemeData(
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
      primaryTextTheme: _buildTextTheme(base.textTheme, "Lato"),
      platform: TargetPlatform.iOS,
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: primaryColor,
        brightness: ThemeData.light().brightness,
        labelStyle: textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w100),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
        endIndent: 1,
        indent: 1,
      ),
      listTileTheme: ListTileThemeData(
        dense: false,
        style: ListTileStyle.list,
        selectedColor: primaryColor,
        //iconColor: secondaryColor,
        //contentPadding: EdgeInsetsGeometry.infinity,
        tileColor: Colors.white,
        selectedTileColor: primaryColor.withOpacity(0.13),
        minLeadingWidth: 4,
        //enableFeedback: false,
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
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  ListTileThemeData appMaterialLightListTileThemeData = ListTileThemeData(
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
      dividerTheme: DividerThemeData(
        color: Colors.grey[500],
        thickness: 1,
        endIndent: 1,
        indent: 1,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, String pFontFamily) {
    var pFontFamily = GoogleFonts.openSans().fontFamily;
    return base.copyWith(
      headline1: base.headline1?.copyWith(
          fontSize: 112, fontFamily: pFontFamily, fontWeight: FontWeight.w900),
      headline2: base.headline2?.copyWith(
          fontSize: 56, fontFamily: pFontFamily, fontWeight: FontWeight.w800),
      headline3: base.headline3?.copyWith(
          fontSize: 45, fontFamily: pFontFamily, fontWeight: FontWeight.w700),
      headline4: base.headline4?.copyWith(
          fontSize: 34, fontFamily: pFontFamily, fontWeight: FontWeight.w600),
      headline5: base.headline5?.copyWith(
          fontSize: 22, fontFamily: pFontFamily, fontWeight: FontWeight.w600),
      headline6: base.headline6?.copyWith(
          fontSize: 15, fontFamily: pFontFamily, fontWeight: FontWeight.w600),
      subtitle1: base.subtitle1?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: pFontFamily,
        color: Colors.black.withOpacity(.5),
      ),
      subtitle2: base.subtitle2?.copyWith(
          fontSize: 13,
          fontFamily: pFontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.grey),
      bodyText1: base.bodyText1?.copyWith(
        fontSize: 12,
        fontFamily: pFontFamily,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: base.bodyText2?.copyWith(
          fontSize: 18,
          fontFamily: pFontFamily,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w300),
      button: base.button?.copyWith(
          fontSize: 17, fontWeight: FontWeight.w600, fontFamily: pFontFamily),
      caption: base.caption?.copyWith(
          fontSize: 19, fontFamily: pFontFamily, fontWeight: FontWeight.w400),
      overline: base.overline?.copyWith(
          fontSize: 19, fontFamily: pFontFamily, fontWeight: FontWeight.w100),
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
