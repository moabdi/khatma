import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/navigation/navigation_bar.dart';
import 'package:khatma/src/features/home/presentation/header/top_card.dart';
import 'package:khatma/src/features/khatma/presentation/list/ui/katmat_list_view.dart';
import 'package:flutter/material.dart';

class KhatmatListScreen extends StatelessWidget {
  const KhatmatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            centerTitle: false,
            leadingWidth: 45,
            pinned: true,
            expandedHeight: 50.0,
            leading: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset("assets/images/khatma/khatma.png"),
              ),
            ),
            backgroundColor: context.colorScheme.primary,
            surfaceTintColor: context.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Khatma",
                    textStyle: Theme.of(context).textTheme.titleMedium!,
                    colors: [
                      Colors.yellowAccent,
                      Colors.yellowAccent,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: context.colorScheme.primary,
              child: TopCard(height: MediaQuery.of(context).size.height / 6),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      gapH24,
                      KhatmatListView(),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}
