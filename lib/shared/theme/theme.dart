import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/colors.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/theme/typography.dart';

class AppTheme {
  final BuildContext context;

  const AppTheme(this.context);

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        inputDecorationTheme: _inputDecorationTheme,
        colorScheme: _lightColorScheme,
        scaffoldBackgroundColor: _lightColorScheme.surface,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: _lightColorScheme.surface,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 24.rw,
          ),
          titleTextStyle: TypographyStyle.medium2.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(_textTheme),
      );

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        inputDecorationTheme: _inputDecorationTheme,
        colorScheme: _darkColorScheme,
        scaffoldBackgroundColor: _darkColorScheme.surface,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: _darkColorScheme.surface,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 24.rw,
          ),
          titleTextStyle: TypographyStyle.medium2.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(_textTheme),
      );

  static final _inputDecorationTheme = InputDecorationTheme(
    labelStyle: TypographyStyle.small1.copyWith(
      color: AColor.secondary.withOpacity(0.68),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: AColor.secondary, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(Constants.smallRadius)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AColor.secondary, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(Constants.smallRadius)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AColor.n75, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(Constants.smallRadius)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AColor.secondary, width: 0.8),
      borderRadius: BorderRadius.all(Radius.circular(Constants.smallRadius)),
    ),
  );

  TextTheme get _textTheme => Theme.of(context).textTheme.copyWith(
        headlineLarge: TypographyStyle.xxLarge,
        headlineMedium: TypographyStyle.xLarge,
        headlineSmall: TypographyStyle.large,
        bodyLarge: TypographyStyle.medium1,
        bodyMedium: TypographyStyle.medium2,
        bodySmall: TypographyStyle.medium3,
        labelLarge: TypographyStyle.small1,
        labelMedium: TypographyStyle.small2,
      );

  ColorScheme get _lightColorScheme => ColorScheme.fromSwatch().copyWith(
        primary: AColor.primary,
        secondary: AColor.secondary,
        surface: AColor.surface,
        onSurface: Colors.white,
        onSurfaceVariant: AColor.n75,
        onBackground: Colors.black,
      );

  ColorScheme get _darkColorScheme => ColorScheme.fromSwatch().copyWith(
        primary: AColor.primary,
        secondary: AColor.secondary,
        surface: AColor.surface,
        onSurface: Colors.white,
        onSurfaceVariant: AColor.n75,
        onBackground: Colors.black,
      );
}
