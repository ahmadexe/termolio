part of '../configs.dart';

abstract class AppTheme {
  static const primary = Color.fromARGB(255, 2, 227, 2);
  static const backgroundDark = Colors.black;

  static ThemeData dark(BuildContext context) => ThemeData(
    useMaterial3: false,
    primaryColor: primary,
    primarySwatch: ThemeUtils.getMaterialColor(primary),
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: backgroundDark,
    textTheme: Theme.of(
      context,
    ).textTheme.apply(bodyColor: primary, displayColor: primary),
  );
}
