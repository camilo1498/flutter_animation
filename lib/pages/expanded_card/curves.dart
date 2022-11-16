import 'package:flutter/animation.dart';

class ExpandableAnimatedContainerCurves {
  static Curve get linear => Curves.linear;

  static Curve get linearToEaseOut => const Cubic(0.35, 0.91, 0.33, 0.97);

  static Curve get fastLinearToSlowEaseIn => const Cubic(0.18, 1.0, 0.04, 1.0);

  static Curve get ease => const Cubic(0.25, 0.1, 0.25, 1.0);

  static Curve get easeIn => const Cubic(0.42, 0.0, 1.0, 1.0);

  static Curve get easeInToLinear => const Cubic(0.67, 0.03, 0.65, 0.09);

  static Curve get easeInSine => const Cubic(0.47, 0.0, 0.745, 0.715);

  static Curve get easeInQuad => const Cubic(0.55, 0.085, 0.68, 0.53);

  static Curve get easeInCubic => const Cubic(0.55, 0.055, 0.675, 0.19);

  static Curve get easeInQuart => const Cubic(0.895, 0.03, 0.685, 0.22);

  static Curve get easeInQuint => const Cubic(0.755, 0.05, 0.855, 0.06);

  static Curve get easeInExpo => const Cubic(0.95, 0.05, 0.795, 0.035);

  static Curve get easeInCirc => const Cubic(0.6, 0.04, 0.98, 0.335);

  static Curve get easeInBack => const Cubic(0.6, -0.28, 0.735, 0.045);

  static Curve get easeOut => const Cubic(0.0, 0.0, 0.58, 1.0);

  static Curve get easeOutSine => const Cubic(0.39, 0.575, 0.565, 1.0);

  static Curve get easeOutQuad => const Cubic(0.25, 0.46, 0.45, 0.94);

  static Curve get easeOutCubic => const Cubic(0.215, 0.61, 0.355, 1.0);

  static Curve get easeOutQuart => const Cubic(0.165, 0.84, 0.44, 1.0);

  static Curve get easeOutQuint => const Cubic(0.23, 1.0, 0.32, 1.0);

  static Curve get easeOutExpo => const Cubic(0.19, 1.0, 0.22, 1.0);

  static Curve get easeOutCirc => const Cubic(0.075, 0.82, 0.165, 1.0);

  static Curve get easeOutBack => const Cubic(0.175, 0.885, 0.32, 1.275);

  static Curve get easeInOut => const Cubic(0.42, 0.0, 0.58, 1.0);

  static Curve get easeInOutSine => const Cubic(0.445, 0.05, 0.55, 0.95);

  static Curve get easeInOutQuad => const Cubic(0.455, 0.03, 0.515, 0.955);

  static Curve get easeInOutCubic => const Cubic(0.645, 0.045, 0.355, 1.0);

  static Curve get easeInOutQuart => const Cubic(0.77, 0.0, 0.175, 1.0);

  static Curve get easeInOutQuint => const Cubic(0.86, 0.0, 0.07, 1.0);

  static Curve get easeInOutExpo => const Cubic(1.0, 0.0, 0.0, 1.0);

  static Curve get easeInOutCirc => const Cubic(0.785, 0.135, 0.15, 0.86);

  static Curve get easeInOutBack => const Cubic(0.68, -0.55, 0.265, 1.55);

  static Curve get easeInOutCubicEmphasized => Curves.easeInOutCubicEmphasized;

  static Curve get fastOutSlowIn => const Cubic(0.4, 0.0, 0.2, 1.0);

  static Curve get slowMiddle => const Cubic(0.15, 0.85, 0.85, 0.15);

  static Curve get bounceIn => Curves.bounceIn;

  static Curve get bounceOut => Curves.bounceOut;

  static Curve get bounceInOut => Curves.bounceInOut;

  static Curve elasticIn({double? period}) {
    return ElasticInCurve(period ?? 0.4);
  }

  static Curve elasticOut({double? period}) {
    return ElasticOutCurve(period ?? 0.4);
  }

  static Curve elasticInOut({double? period}) {
    return ElasticInOutCurve(period ?? 0.4);
  }

}