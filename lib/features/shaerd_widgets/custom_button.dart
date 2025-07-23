import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
      this.text,
    this.child,
    this.color
  });

  final void Function()? onPressed;
  final String? text;
final Widget? child;
final Color? color;
  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:color?? AppColors.primary,
        foregroundColor: Colors.black,
        alignment: Alignment.center,
        minimumSize: const Size(double.infinity, AppSize.buttonHeight),
        padding: AppSize.symmetricPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
      ),
      child:child?? Text(text??'',style: textStyles.button.copyWith(color: AppColors.darkTextPrimary),),
    );
  }
}
