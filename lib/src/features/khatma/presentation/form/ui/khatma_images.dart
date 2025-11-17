import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<String> imagesNames = List<String>.empty(growable: true)
  ..addAll(khatmaIconsMap.keys);

Icon getIcon(String key, {Color? color, double? size}) {
  var iconData = Icons.brightness_high;

  if (khatmaIconsMap.containsKey(key)) {
    iconData = khatmaIconsMap[key]!;
  }
  return Icon(
    iconData,
    size: size,
    color: color,
  );
}

final Map<String, IconData> khatmaIconsMap = {
  'kaaba.ico': FontAwesomeIcons.kaaba,
  'bookQuran.ico': FontAwesomeIcons.bookQuran,
  'auto_stories.ico': Icons.auto_stories,
  'book.ico': Icons.book,
  'bookAtlas.ico': FontAwesomeIcons.bookAtlas,
  'menu_book.ico': Icons.menu_book,
  'bookmark.ico': Icons.bookmark,
  'brightness_low.ico': Icons.brightness_low,
  'brightness_high.ico': Icons.brightness_high,
  'mosque.ico': Icons.mosque,
  'collections_bookmark.ico': Icons.collections_bookmark,
  'library_books.ico': Icons.library_books,
  'bookmark_border.ico': Icons.bookmark_border,
  'bookmarks.ico': Icons.bookmarks,
  'calendar_month.ico': Icons.calendar_month,
  'mosque_fa.ico': FontAwesomeIcons.mosque,
  'starAndCrescent.ico': FontAwesomeIcons.starAndCrescent,
  'crown.ico': FontAwesomeIcons.crown,
  'leanpub.ico': FontAwesomeIcons.leanpub,
};
