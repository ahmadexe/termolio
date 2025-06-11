part of '../configs.dart';

extension SuperEdgeInsets on EdgeInsets {
  EdgeInsets st([plus = 0, bool un = false]) {
    final base = top + AppMedia.padding.top;
    return copyWith(top: base + (un ? plus.fs() : plus.toDouble()));
  }

  EdgeInsets sb([plus = 0, bool un = false]) {
    final base = bottom + AppMedia.padding.bottom;
    return copyWith(bottom: base + (un ? plus.fs() : plus.toDouble()));
  }

  EdgeInsets h(num no, [bool un = false]) {
    final val = un ? no.fs() : no.toDouble();
    return copyWith(top: val, bottom: val);
  }

  EdgeInsets v(num no, [bool un = false]) {
    final val = un ? no.fs() : no.toDouble();
    return copyWith(top: val, bottom: val);
  }

  EdgeInsets b(num no, [bool un = false]) {
    return copyWith(bottom: un ? no.fs() : no.toDouble());
  }

  EdgeInsets t(num no, [bool un = false]) {
    return copyWith(top: un ? no.fs() : no.toDouble());
  }

  EdgeInsets l(num no, [bool un = false]) {
    return copyWith(left: un ? no.fs() : no.toDouble());
  }

  EdgeInsets r(num no, [bool un = false]) {
    return copyWith(right: un ? no.fs() : no.toDouble());
  }
}
