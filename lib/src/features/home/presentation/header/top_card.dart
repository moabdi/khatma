import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/constants/lottie_asset.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height * .9,
          padding: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.centerRight,
              image: AssetImage('assets/images/hifdz.png'),
              opacity: 0.3,
            ),
          ),
          width: double.infinity,
          child: lottieStartReading,
        ),
        Container(
          padding: EdgeInsets.only(right: 0),
          height: (height * .5),
          width: double.infinity,
          child: SizedBox(
            width: height * .8,
            child: DefaultTextStyle(
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.yellowAccent),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    animatedTexts: [
                      animateText(context,
                          'وَلَقَدْ يَسَّرْنَا الْقُرْآنَ لِلذِّكْرِ فَهَلْ مِنْ مُدَّكِرٍ '),
                      animateText(context, 'فَاقْرَءُوا مَا تَيَسَّرَ مِنْهُ'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ColorizeAnimatedText animateText(BuildContext context, String text) {
    return ColorizeAnimatedText(
      text,
      textStyle: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontSize: min(height * .25, 18)),
      colors: [Colors.white, Colors.yellowAccent],
      textDirection: TextDirection.rtl,
      speed: Duration(milliseconds: 100),
    );
  }
}
