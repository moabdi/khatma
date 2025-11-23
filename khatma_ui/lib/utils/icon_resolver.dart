import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Icon resolver utility for mapping string keys to IconData
///
/// Provides a way to store and retrieve icons by string keys.
/// Useful for dynamic icon selection from data sources.

/// Default icon map with common Material and FontAwesome icons
final Map<String, IconData> defaultIconMap = {
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

/// Get icon from string key
///
/// Returns the IconData for the given key, or a default icon if not found.
Icon getIcon(
  String key, {
  Color? color,
  double? size,
  Map<String, IconData>? iconMap,
  IconData defaultIcon = Icons.brightness_high,
}) {
  final map = iconMap ?? defaultIconMap;
  final iconData = map[key] ?? defaultIcon;

  return Icon(
    iconData,
    size: size,
    color: color,
  );
}

/// Get list of all icon names
List<String> getIconNames({Map<String, IconData>? iconMap}) {
  final map = iconMap ?? defaultIconMap;
  return map.keys.toList();
}
