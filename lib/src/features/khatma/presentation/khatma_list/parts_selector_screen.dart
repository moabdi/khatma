import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma_app/src/common_widgets/async_value_widget.dart';
import 'package:khatma_app/src/common_widgets/safe_text.dart';
import 'package:khatma_app/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma_app/src/features/khatma/data/parts_repository.dart';
import 'package:khatma_app/src/features/khatma/domain/part.dart';
import 'package:khatma_app/src/features/khatma/presentation/home_app_bar/home_app_bar.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:khatma_app/src/themes/theme.dart';

class PartSelectorScreen extends ConsumerWidget {
  const PartSelectorScreen({super.key, required this.khatmaId});
  final String khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsListValue = ref.watch(partListFutureProvider);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final khatmaValue = ref.watch(khatmaProvider(khatmaId));
          return  AsyncValueWidget<List<Part>>(
          value: partsListValue,
          data: (parts) => parts.isEmpty
              ? Text(
                'No khatma found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              )
              :  ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 2,),
                  itemCount: parts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var part = parts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:AppTheme.getTheme().primaryColor,
                        child: Text(part.id.toString(),
                        style: const TextStyle(color: Colors.white),),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SafeText(part.translation, maxLength: 20,),
                          SafeText(part.name, maxLength: 25,),
                        ],
                      ),
                      subtitle: Text(part.transliteration),
                    );
                  },
                ),
        );
        
  },
      ),
    );
  }
}