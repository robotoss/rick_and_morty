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
}
