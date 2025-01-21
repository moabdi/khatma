import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class RecurrenceText extends StatelessWidget {
  final Recurrence recurrence;
  final TextStyle? style;

  const RecurrenceText(this.recurrence, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return recurrence.repeat
        ? Text(_buildRepeatText(recurrence, context))
        : Row(
            children: [
              Icon(
                size: 12,
                Icons.info,
                color: Theme.of(context).colorScheme.warning,
              ),
              gapW4,
              Text(AppLocalizations.of(context).noRepeatDescription),
            ],
          );
  }

  String _buildRepeatText(Recurrence recurrence, BuildContext context) {
    switch (recurrence.unit) {
      case RepeatInterval.auto:
        return AppLocalizations.of(context).autoRepeatDescription;
      case RepeatInterval.weekly:
        return _buildWeekText(context, recurrence);
      default:
        {
          String unit = AppLocalizations.of(context)
              .repeatInterval(recurrence.unit.name)
              .toLowerCase();
          if (recurrence.frequency == 1) {
            return AppLocalizations.of(context)
                .repeatEveryTimePeriodDescription(unit);
          } else {
            return AppLocalizations.of(context)
                .repeatEveryTimePeriodsDescription(
                    recurrence.frequency.toString(), unit);
          }
        }
    }
  }

  String _buildWeekText(BuildContext context, Recurrence recurrence) {
    String dayNamesString = "";
    if (recurrence.daysOfWeek.isEmpty) {
      dayNamesString = AppLocalizations.of(context).weekDay("1").toLowerCase();
    } else {
      List<int> days = List.from(recurrence.days!);
      days.sort((a, b) => a.compareTo(b));
      List<String> selectedDayNames = days
          .map((day) => AppLocalizations.of(context)
              .weekDay(day.toString())
              .toLowerCase())
          .toList();

      dayNamesString = selectedDayNames.join(", ");
    }

    if (recurrence.frequency == 1) {
      return AppLocalizations.of(context)
          .repeatEverySelectedDayDescription(dayNamesString);
    }
    return AppLocalizations.of(context).repeatEverySelectedDaysDescription(
        recurrence.frequency.toString(), dayNamesString);
  }
}
