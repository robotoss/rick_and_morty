import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

// Text Styles for text don't uses in textTheme
class AppTextStyles {
  static final subTitle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppColors.subTitle.withOpacity(0.6),
  );

  static final charName = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static final infoItemTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    letterSpacing: 1.5,
  );

  static final infoItemValue = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static final infoItemDate = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
  );
}
