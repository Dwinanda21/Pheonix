import 'package:flutter/material.dart';

class TextStyleConstant {
  static const TextStyle _baseLato = TextStyle(
    fontFamily: 'Lato',
  );

  static TextStyle titleLarge = _baseLato.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleMedium = _baseLato.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleSmall = _baseLato.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyLarge = _baseLato.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyMedium = _baseLato.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodySmall = _baseLato.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle captionLarge = _baseLato.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle captionMedium = _baseLato.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle captionSmall = _baseLato.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
