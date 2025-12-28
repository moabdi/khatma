import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/navigation/navigation_bar.dart';
import 'package:khatma/src/features/home/presentation/header/top_card.dart';
import 'package:khatma/src/features/khatma/presentation/list/widgets/katmat_list_view.dart';
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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.primary.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: context.colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Image.asset("assets/images/khatma/khatma.png"),
                ),
              ),
            ),
            backgroundColor: context.colorScheme.primaryContainer,
            surfaceTintColor: context.colorScheme.primaryContainer,
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
                      context.colorScheme.primary,
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: context.colorScheme.primaryContainer,
              child: TopCard(height: MediaQuery.of(context).size.height / 6),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    KhatmatListView(),
                  ],
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
