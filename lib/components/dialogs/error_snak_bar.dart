import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

void showErrorSnakBar(BuildContext context, String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    backgroundColor: AppColors.red,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    borderRadius: BorderRadius.circular(10),
    margin: const EdgeInsets.symmetric(horizontal: 16),
  ).show(context);
}
