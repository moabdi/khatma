import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class TopKhatmaCard extends StatelessWidget {
  const TopKhatmaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              AppTheme.getTheme().primaryColor.withOpacity(.2),
              AppTheme.getTheme().primaryColor.withOpacity(.7),
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

  Widget buildIndicator(
      {required Icon icon, required String title, required int count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              AppTheme.getTheme().colorScheme.background.withOpacity(0.5),
          radius: 25,
          child: icon,
        ),
        Text(
          count.toString(),
          style: AppTheme.getTheme()
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
