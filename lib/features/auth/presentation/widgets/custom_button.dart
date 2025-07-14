import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final String child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pYellow,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, AppSize.buttonHeight),
        padding: AppSize.symmetricPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
      ),
      child: Text(child,style: AppTextStyles.button.copyWith(color: AppColors.darkBackground),),
    );
  }
}
