import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FontStyles {
  static final TextTheme textTheme = GoogleFonts.nunitoTextTheme();

  static final title = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final description = GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  static final regular = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static final normal = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
