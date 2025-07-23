
import 'package:flutter/material.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({
    super.key,
    required this.r,
    required this.textStyle,
    required this.title,
    required this.icon, this.trailing,
  });

  final Responsive r;
  final AppTextStyles textStyle;
  final String title;
  final IconData icon;
  final Widget ? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  icon
                  ,
                  color: AppColors.primary,
                  size: r.radius(10),
                ),
              ),
              TextSpan(
                text:title,
                style: textStyle.heading1.copyWith(
                  fontSize: r.sp(6),
                ),
              ),
            ],
          ),
        ),
        trailing ?? const SizedBox(),
      ],
    );
  }
}
