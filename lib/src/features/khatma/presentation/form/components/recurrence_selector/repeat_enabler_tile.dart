import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RepeatEnablerTile extends ConsumerWidget {
  const RepeatEnablerTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return ListTile(
      title: Text(AppLocalizations.of(context).repeat),
      subtitle: Text(AppLocalizations.of(context).repeatDescription),
      leading: _buildLeading(context),
      trailing: _buildTrailing(updatedRecurrence, ref),
      onTap: () => ref.read(formRecurrenceProvider).update(
          updatedRecurrence.copyWith(repeat: !updatedRecurrence.repeat)),
    );
  }

  Switch _buildTrailing(Recurrence updatedRecurrence, WidgetRef ref) {
    return Switch(
        value: updatedRecurrence.repeat,
        onChanged: (value) => ref
            .read(formRecurrenceProvider)
            .update(updatedRecurrence.copyWith(repeat: value)));
  }

  Avatar _buildLeading(BuildContext context) {
    return Avatar(
      radius: 30,
      backgroundColor: Theme.of(context).disabledColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.autorenew,
        color: Theme.of(context).primaryColor,
        size: 25,
      ),
    );
  }
}
