import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final lottieCheckAsset = Lottie.asset(
  'assets/lottie/check.json',
  width: 35,
  height: 35,
  fit: BoxFit.fill,
  repeat: false,
);

final lottieSuccessAsset = Lottie.asset(
  'assets/lottie/success.json',
  width: double.infinity,
  height: 200,
  repeat: false,
  animate: true,
);

final lottieCongratAsset = Lottie.asset(
  'assets/lottie/congratulation.json',
  width: 500,
  height: 200,
  repeat: true,
  animate: true,
);

final lottieStartReading = Lottie.asset(
  'assets/lottie/reading.json',
  repeat: false,
);

final lottieNoData = Lottie.asset(
  'assets/lottie/not_found.json',
  width: 200,
  repeat: true,
  animate: true,
);
