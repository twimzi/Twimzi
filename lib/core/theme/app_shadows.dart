import 'package:flutter/material.dart';

import 'app_colors.dart';

class TwimziShadows {
  const TwimziShadows._();

  static const card = [
    BoxShadow(
      color: TwimziColors.shadow,
      blurRadius: 12,
      spreadRadius: 1,
      offset: Offset(0, 3),
    ),
  ];
}