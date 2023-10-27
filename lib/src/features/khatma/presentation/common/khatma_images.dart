import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<String> imagesNames = List<String>.empty(growable: true)
  ..addAll(khatmaImagesMap.keys)
  ..addAll(khatmaIconsMap.keys);

Widget getImage(String? key, {double? size, Color? color}) {
  if (key == null) {
    return Image.asset(
      getImagePath('assets/images/khatma/khatma.png'),
      width: size,
    );
  }

  if (key.endsWith('.ico')) {
    // If the key ends with ".ico", treat it as an icon
    return Icon(
      getIconData(key),
      size: size,
      color: color,
    );
  } else {
    // Otherwise, treat it as an image
    return Image.asset(
      getImagePath(key),
      width: size,
    );
  }
}

String getImagePath(String key) {
  const defaultValue = 'assets/images/khatma/khatma.png';

  if (khatmaImagesMap.containsKey(key)) {
    return khatmaImagesMap[key]!;
  } else {
    return defaultValue;
  }
}

IconData getIconData(String key) {
  const defaultValue = Icons.brightness_high;

  if (khatmaIconsMap.containsKey(key)) {
    return khatmaIconsMap[key]!;
  } else {
    return defaultValue;
  }
}

final Map<String, String> khatmaImagesMap = {
  'khatma.png': 'assets/images/khatma/khatma.png',
  'mosaic.png': 'assets/images/khatma/mosaic.png',
  'pattern.png': 'assets/images/khatma/pattern.png',
  'ornament.png': 'assets/images/khatma/ornament.png',
  'aya.png': 'assets/images/khatma/aya.png',
  'decoration.png': 'assets/images/khatma/decoration.png',
  'lune.png': 'assets/images/khatma/lune.png',
  'lune_1.png': 'assets/images/khatma/lune_1.png',
  'lune_2.png': 'assets/images/khatma/lune_2.png',
  'musulman.png': 'assets/images/khatma/musulman.png',
  'ramadan.png': 'assets/images/khatma/ramadan.png',
  'coran_1.png': 'assets/images/khatma/coran_1.png',
  'islam.png': 'assets/images/khatma/islam.png',
  'lanterne.png': 'assets/images/khatma/lanterne.png',
  'moon.png': 'assets/images/khatma/moon.png',
  'mosque_1.png': 'assets/images/khatma/mosque_1.png',
  'mosque_2.png': 'assets/images/khatma/mosque_2.png',
  'mosque.png': 'assets/images/khatma/mosque.png',
};

final Map<String, IconData> khatmaIconsMap = {
  'kaaba.ico': FontAwesomeIcons.kaaba,
  'bookQuran.ico': FontAwesomeIcons.bookQuran,
  'auto_stories.ico': Icons.auto_stories,
  'book.ico': Icons.book,
  'bookAtlas.ico': FontAwesomeIcons.bookAtlas,
  'bookOpenReader.ico': FontAwesomeIcons.bookOpenReader,
  'bookOpen.ico': FontAwesomeIcons.bookOpen,
  'readme.ico': FontAwesomeIcons.readme,
  'menu_book.ico': Icons.menu_book,
  'bookmark.ico': Icons.bookmark,
  'warehouse.ico': Icons.warehouse,
  'grid_view.ico': Icons.grid_view,
  'dark_mode.ico': Icons.dark_mode,
  'light_mode.ico': Icons.light_mode,
  'brightness_low.ico': Icons.brightness_low,
  'brightness_high.ico': Icons.brightness_high,
  'mosque.ico': Icons.mosque,
  'collections_bookmark.ico': Icons.collections_bookmark,
  'library_books.ico': Icons.library_books,
  'bookmark_border.ico': Icons.bookmark_border,
  'bookmarks.ico': Icons.bookmarks,
  'calendar_month.ico': Icons.calendar_month,
  'calendar_today.ico': Icons.calendar_today,
  'mosque_fa.ico': FontAwesomeIcons.mosque,
  'starAndCrescent.ico': FontAwesomeIcons.starAndCrescent,
  'crown.ico': FontAwesomeIcons.crown,
  'microsoft.ico': FontAwesomeIcons.microsoft,
  'feather.ico': FontAwesomeIcons.feather,
  'leanpub.ico': FontAwesomeIcons.leanpub,
};
