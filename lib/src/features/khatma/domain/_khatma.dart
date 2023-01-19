import 'package:flutter/material.dart';
import 'package:khatma_app/src/features/khatma/domain/part.dart';
import 'package:khatma_app/src/features/khatma/domain/sourat.dart';
import 'package:khatma_app/src/themes/theme.dart';
import 'package:khatma_app/src/utils/common.dart';



class Khatma {
  String? id;
  String name;
  String description;
  DateTime? start;
  DateTime? end;
  String? creator;
  bool permanent = false;
  KhatmaStatus status;
  double completion = 0;
  List<int> parts = [];
  KhatmaUnit unit;
  Part? part;
  Sourat? sourat;
  KhatmaDecorator? decorator;

  Khatma({
    this.id,
    required this.name,
    required this.description,
    this.start,
    this.end,
    this.creator,
    this.permanent = false,
    this.status = KhatmaStatus.created,
    this.completion = 0,
    this.parts = const [],
    this.unit = KhatmaUnit.hizb,
  });
}

class KhatmaDecorator {
  Color color;
  String imagePath;
  Color? backgroundImage;
  KhatmaUnit unit;

  KhatmaDecorator({
    required this.color,
    required this.imagePath,
    this.backgroundImage,
    required this.unit,
  });

  static KhatmaDecorator juzz = KhatmaDecorator(
    color: HexColor("#3AA8DE"),
    imagePath: "assets/images/quran_border_while.png",
    backgroundImage: null,
    unit: KhatmaUnit.juzz,
  );
  static KhatmaDecorator hizb = KhatmaDecorator(
    color: HexColor("#18D39F"),
    imagePath: "assets/images/quran_read.png",
    backgroundImage: Colors.white,
    unit: KhatmaUnit.hizb,
  );

  static KhatmaDecorator sourat = KhatmaDecorator(
    color: HexColor("#EBB953"),
    imagePath: "assets/images/aya_marker.png",
    backgroundImage: Colors.white,
    unit: KhatmaUnit.sourat,
  );

  static List<KhatmaDecorator> list = [juzz, hizb, sourat];
}

enum KhatmaType { friday, monthly, ramadan, custom }
enum KhatmaStatus { created, progress, completed, cancelled, finished }
enum KhatmaUnit { sourat, hizb, juzz }

extension KhatmaUnitExtension on KhatmaUnit {
  String translate(BuildContext context) {
    switch (this) {
      case KhatmaUnit.sourat:
        return "Sourat"; //AppLocalizations.of(context)!.sourat;
      case KhatmaUnit.hizb:
        return "Hizb"; // AppLocalizations.of(context)!.hizb;
      default:
        return "Juzz"; //AppLocalizations.of(context)!.juzz;
    }
  }
}
