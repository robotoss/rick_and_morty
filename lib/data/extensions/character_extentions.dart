import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

extension StoreDistance on Character {
  Color get statusColor {
    if (status == 'Alive') {
      return AppColors.green;
    } else if (status == 'Dead') {
      return AppColors.red;
    } else {
      return AppColors.subTitle;
    }
  }
}
