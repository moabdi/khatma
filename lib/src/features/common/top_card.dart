import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/lottie_asset.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              alignment: Alignment.bottomRight,
              image: AssetImage('assets/images/hifdz.png'),
              opacity: 0.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(.01),
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          width: double.infinity,
          child: lottieStartReading,
        ),
        Container(
          padding: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          height: 80.0,
          width: double.infinity,
          child: SizedBox(
            width: 150.0,
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
      textStyle: Theme.of(context).textTheme.headlineMedium!,
      colors: [Colors.white, Colors.yellowAccent],
      textDirection: TextDirection.rtl,
      speed: Duration(milliseconds: 100),
    );
  }
}
