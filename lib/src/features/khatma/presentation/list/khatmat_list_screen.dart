import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/common/navigation_bar.dart';
import 'package:khatma/src/common/widgets/app_bar.dart';
import 'package:khatma/src/features/khatma/presentation/list/katmat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';

/// Shows the list of khatmas with a search field at the top.
class KhatmatListScreen extends StatelessWidget {
  const KhatmatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: const MainDrawer(),
      appBar: TopBar(title: AppLocalizations.of(context).appTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              //WeeklyProgressChart(),
              gapH20,
              const KhatmatListView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}
