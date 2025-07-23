import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_assets.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';

class UserTypeSelectorPage extends StatelessWidget {
  const UserTypeSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
        final textStyles = AppTextStyles(context);

    return Scaffold(
      body: Padding(
        padding: AppSize.defaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                   Image.asset(AppAssets.logo, height: 150),
                      AppSize.verticalSpace(16),
                      Text(
                        'مرحباً بك 👋',
                        style: textStyles.body.copyWith(
                           fontSize: 20,
                        ),
                      ),
                      AppSize.verticalSpace(8),
                      Text(
                        'برجاء تحديد نوع المستخدم.',
                        style: textStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSize.verticalSpace(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomSqIconTextButton(
                    onTap: () => context.push(AppRoutes.teacherLogin),
                    title: 'أنا مدرس',
                    icon: Icons.school,
                    color: AppColors.primaryLight,
                    textStyles: textStyles, 
                  ),
                  AppSize.verticalSpace(16),
                  CustomSqIconTextButton(
                    onTap: () => context.push(AppRoutes.parentLogin),
                    title: 'أنا ولي أمر',
                    icon: Icons.family_restroom,
                    color: AppColors.primary,
                    textStyles: textStyles,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSqIconTextButton extends StatelessWidget {
  const CustomSqIconTextButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.color,
    required this.textStyles,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Color color;
  final   AppTextStyles  textStyles  ;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        padding: AppSize.defaultPadding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.lightBackground, size: 45),
            AppSize.verticalSpace(8),
            Text(
              title,
              style: textStyles.heading3.copyWith(
                color: AppColors.lightBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
