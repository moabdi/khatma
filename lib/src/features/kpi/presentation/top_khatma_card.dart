import 'package:flutter/material.dart';

class TopKhatmaCard extends StatelessWidget {
  const TopKhatmaCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onTap: () {},
      child: Ink(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomLeft,
            colors: [
              theme.primaryColor.withOpacity(.2),
              theme.primaryColor.withOpacity(.7),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [],
                ),
              ),
            ),
            Image.asset(
              "assets/images/hifdz.png",
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator({
    required BuildContext context,
    required Icon icon,
    required String title,
    required int count,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: theme.colorScheme.background.withOpacity(0.5),
          radius: 25,
          child: icon,
        ),
        Text(
          count.toString(),
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
