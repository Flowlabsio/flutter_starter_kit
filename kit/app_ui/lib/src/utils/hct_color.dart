import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class HctColor {
  static Map<int, Color> generateMaterial3TonesHct(Hct baseColor) {
    final double baseHue = baseColor.hue;
    final double baseChroma = baseColor.chroma;

    final Map<int, Color> colorMap = {};

    for (int tone = 0; tone <= 100; tone++) {
      final Hct hctToned = Hct.from(baseHue, baseChroma, tone.toDouble());
      colorMap[tone] = Color(hctToned.toInt());
    }

    return colorMap;
  }
}
