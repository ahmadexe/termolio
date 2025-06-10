part of '../configs.dart';

extension SuperDouble on double {
  double un() => AppUnit.un(this);
  double fs() => AppUnit.sp(this);
  double font() => AppUnit.font(this);

  BorderRadius radius() => BorderRadius.circular(this);

  double percentOf(num total) {
    if (total == 0) {
      throw ArgumentError("Total cannot be zero");
    }
    return (this / total) * 100;
  }

  double addPercent(num percent) {
    return this + (this * percent / 100);
  }
}
