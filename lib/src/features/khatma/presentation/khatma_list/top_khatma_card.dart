import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khatma_app/src/themes/theme.dart';

class TopKhatmaCard extends StatelessWidget {
  const TopKhatmaCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: HexColor("#25B8A0"),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      onTap: () {},
      child: Ink(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomLeft,
            colors: [
              HexColor("#9EDCC7"),
              HexColor("#25B8A0"),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  children: [
                  ],
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
          backgroundColor: AppTheme.getTheme().backgroundColor.withOpacity(0.5),
          child: icon,
          radius: 25,
        ),
        Text(
          count.toString(),
          style: AppTheme.getTheme()
              .textTheme
              .headline5!
              .copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
