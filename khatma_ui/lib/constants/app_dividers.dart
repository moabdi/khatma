import 'package:flutter/material.dart';

class Sizes {
  static const p0_5 = 0.5;
  static const p1 = 1.0;
  static const p1_5 = 1.5;
  static const p2 = 2.0;
}

const dividerH0_5T1 = Divider(height: Sizes.p0_5, thickness: Sizes.p1);
const dividerH1_5T0_5 = Divider(height: Sizes.p1, thickness: Sizes.p0_5);
const dividerH1T0_5 = Divider(height: Sizes.p1, thickness: Sizes.p0_5);
const dividerH1T1 = Divider(height: Sizes.p1, thickness: Sizes.p1);
const dividerH1T2 = Divider(height: Sizes.p1, thickness: Sizes.p2);
const dividerH2T1 = Divider(height: Sizes.p2, thickness: Sizes.p1);
const dividerH2T2 = Divider(height: Sizes.p2, thickness: Sizes.p2);
