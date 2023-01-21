
import 'package:flutter/material.dart';

enum KhatmaType { friday, monthly, ramadan, custom }
enum KhatmaStatus { created, progress, completed, cancelled, finished }
enum KhatmaUnit { sourat, hizb, juzz, quart, roubaa }

extension KhatmaUnitExtension on KhatmaUnit {
  String translate(BuildContext context) {
    switch (this) {
      case KhatmaUnit.sourat:
        return "Sourat";//AppLocalizations.of(context)!.sourat;
      case KhatmaUnit.hizb:
        return "Hizb";//AppLocalizations.of(context)!.hizb;
      default:
        return "Juzz";//AppLocalizations.of(context)!.juzz;
    }
  }
}