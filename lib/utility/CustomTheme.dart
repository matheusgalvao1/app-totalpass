import 'package:flutter/material.dart';

import 'Style.dart';

class CustomTheme {
  // DARK
  static ThemeData dark = ThemeData(
    accentColor: Colored.white,
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      color: Colored.black,
      iconTheme: IconThemeData(
        color: Colored.grayDark,
      ),
    ),
    // bottomSheetTheme: BottomSheetThemeData(
    //   backgroundColor: Colors.black.withOpacity(0),
    // ),
    brightness: Brightness.dark,
    buttonColor: Colored.greenLight,
    colorScheme: _ColorScheme.dark,
    cursorColor: Colored.group01Medium,
    disabledColor: Colored.white,
    indicatorColor: Colored.greenDark,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    primaryColor: Colored.grayLight,
    primaryColorDark: Colored.white,
    primaryColorLight: Colored.white,
    scaffoldBackgroundColor: Colors.black,
    splashColor: Colors.transparent,
    textSelectionColor: Colored.backGroundLight.withOpacity(0.2),
    textSelectionHandleColor: Colored.group01Medium,
    textTheme: const TextTheme(
      headline1: Styled.headline1Dark,
      headline2: Styled.headline2Dark,
      headline3: Styled.headline3Dark,
      headline4: Styled.headline4Dark,
      headline5: Styled.headline5Dark,
      headline6: Styled.headline6Dark,
      subtitle1: Styled.subtitle1Dark,
      subtitle2: Styled.subtitle2Dark,
      bodyText1: Styled.bodyText1Dark,
      bodyText2: Styled.bodyText2Dark,
      button: Styled.buttonDark,
      caption: Styled.captionDark,
    ),
  );
}

class _ColorScheme {
  static ColorScheme get dark => _colorScheme(Brightness.dark, Colors.black);

  static ColorScheme _colorScheme(Brightness brightness, Color background) =>
      ColorScheme(
        brightness: brightness,
        // GROUP01
        primary: Colored.group01Light,
        primaryVariant: Colored.group01Medium,
        onPrimary: Colored.group01Dark,
        // GROUP02
        secondary: Colors.red,
        secondaryVariant: Colored.group02Medium,
        onSecondary: Colored.group02Dark,
        // GROUP03
        background: background,
        error: Colored.group03Medium,
        onBackground: Colored.group03Dark,
        // GROUP04
        onError: Colored.group04Light,
        onSurface: Colored.group04Medium,
        surface: Colored.group04Dark,
      );
}
