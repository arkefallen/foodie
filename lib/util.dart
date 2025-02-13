import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme.copyWith();
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme).copyWith();
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

TextTheme normalizeTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    displayLarge: textTheme.displayLarge?.copyWith(inherit: true),
    displayMedium: textTheme.displayMedium?.copyWith(inherit: true),
    displaySmall: textTheme.displaySmall?.copyWith(inherit: true),
    bodyLarge: textTheme.bodyLarge?.copyWith(inherit: true),
    bodyMedium: textTheme.bodyMedium?.copyWith(inherit: true),
    bodySmall: textTheme.bodySmall?.copyWith(inherit: true),
    labelLarge: textTheme.labelLarge?.copyWith(inherit: true),
    labelMedium: textTheme.labelMedium?.copyWith(inherit: true),
    labelSmall: textTheme.labelSmall?.copyWith(inherit: true),
  );
}