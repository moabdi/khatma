import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/avatar.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class TypeSelector extends StatelessWidget {
  const TypeSelector({super.key, required this.type, required this.onSelect});
  final KhatmaType type;
  final ValueChanged<KhatmaType> onSelect;

  @override
  Widget build(BuildContext context) {
    Map<KhatmaType, IconData> typeIcons = {
      KhatmaType.personal: Icons.person,
      KhatmaType.shared: Icons.group,
      KhatmaType.hifz: Icons.school,
    };

    Map<KhatmaType, String> typeDescriptions = {
      KhatmaType.personal: 'Track your personal Quran reading',
      KhatmaType.shared: 'Share with family and friends',
      KhatmaType.hifz: 'Memorization tracking',
    };

    return Card(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: KhatmaType.values.length,
            itemBuilder: (BuildContext context, int index) {
              var currentType = KhatmaType.values[index];
              var selected = type == currentType;
              return Padding(
                padding: const EdgeInsets.all(3),
                child: ListTile(
                  minVerticalPadding: 0,
                  selected: selected,
                  title: Text(
                    currentType.name[0].toUpperCase() + currentType.name.substring(1),
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(typeDescriptions[currentType] ?? ''),
                  leading: Avatar(
                    radius: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    bottom: selected
                        ? Avatar(
                            radius: 10,
                            child: Icon(
                              size: 18,
                              color: context.colorScheme.primary,
                              selected
                                  ? Icons.check_circle_rounded
                                  : Icons.circle_outlined,
                            ))
                        : null,
                    child: Icon(
                      typeIcons[currentType],
                      color: context.colorScheme.primary,
                      size: 32,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(currentType);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
