import 'package:flutter/material.dart';

class Cols extends InheritedWidget {
  const Cols({
    super.key,
    required this.c,
    required super.child,
  });

  final AppColor c;

  static Cols? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Cols>();
  }

  static Cols of(BuildContext context) {
    final Cols? result = maybeOf(context);
    assert(result != null, 'No Cols found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Cols oldWidget) => c != oldWidget.c;
}

abstract class AppColor {
  Color get background;
  Color get headline;
  Color get textdark;
  Color get textlight;
}

class AppColorLight extends AppColor {
  @override
  Color get background => Colors.white;
  @override
  Color get headline => Colors.black;
  @override
  Color get textdark => Colors.black;
  @override
  Color get textlight => Colors.grey;
}

class AppColorDark extends AppColor {
  @override
  Color get background => Colors.white;
  @override
  Color get headline => Colors.white;
  @override
  Color get textdark => Colors.white;
  @override
  Color get textlight => Colors.grey;
}
