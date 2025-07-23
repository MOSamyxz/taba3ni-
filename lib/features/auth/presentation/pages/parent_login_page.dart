import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/core/constants/app_assets.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_state.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/shaerd_widgets/gradiant_text_field.dart';

import '../cubit/auth_cubit.dart';

class ParentLoginPage extends StatefulWidget {
  const ParentLoginPage({super.key});

  @override
  State<ParentLoginPage> createState() => _ParentLoginPageState();
}

class _ParentLoginPageState extends State<ParentLoginPage> {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is AuthSuccess) {
             final  user = state.user;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(user.name),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            final textStyles = AppTextStyles(context);

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
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
                        'أدخل بيانات ابنك لمتابعته داخل المجموعة.',
                        style: textStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSize.verticalSpace(32),
                      GradientTextField(
                        controller: usernameController,
                        hintText: 'اسم المستخدم',
                        prefix: Icons.person,
                        validator:
                            (value) =>
                                value != null && value.length >= 3
                                    ? null
                                    : 'أدخل اسم صحيح',
                      ),
                      AppSize.verticalSpace(32),
                      GradientTextField(
                        controller: phoneController,
                        hintText: 'رقم هاتف ولي الأمر',
                        prefix: Icons.phone,
                        inputType: TextInputType.phone,
                        validator:
                            (value) =>
                                value != null && value.length == 11
                                    ? null
                                    : 'أدخل رقم صحيح',
                      ),
                      AppSize.verticalSpace(32),
                      state is AuthLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().loginAsParent(
                                  usernameController.text.trim(),
                                  phoneController.text.trim(),
                                );
                              }
                            },
                            text: 'تسجيل دخول',
                          ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
