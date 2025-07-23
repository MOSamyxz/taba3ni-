
import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_assets.dart';
import 'package:taba3ni/core/constants/app_colors.dart';

Color getCardColor(String grade) {
  switch (grade) {
    case 'primary':
      return AppColors.pYellow;
    case 'middle':
      return AppColors.pBlue;
    case 'high':
      return AppColors.pGreen;
    default:
      return AppColors.disabled;
  }
}

Color getSecendCardColor(String grade) {
  switch (grade) {
    case 'primary':
      return AppColors.pLightYellow;
    case 'middle':
      return AppColors.pLightBlue;
    case 'high':
      return AppColors.pLightGreen;
    default:
      return AppColors.disabled;
  }
}

String getGrade(String grade) {
  switch (grade) {
    case 'primary':
      return 'ابتدائي';
    case 'middle':
      return "إعدادي";
    case 'high':
      return "ثانوي";
    default:
      return "";
  }
}

String getImage(String grade) {
  switch (grade) {
    case 'primary':
      return AppAssets.lyBG;
    case 'middle':
      return AppAssets.lbBG;
    case 'high':
      return AppAssets.lgBG;
    default:
      return "";
  }
}
