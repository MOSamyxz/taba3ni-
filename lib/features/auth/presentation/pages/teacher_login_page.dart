import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_assets.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_state.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/shaerd_widgets/gradiant_text_field.dart';
import '../cubit/auth_cubit.dart';

class TeacherLoginPage extends StatefulWidget {
  const TeacherLoginPage({super.key});

  @override
  State<TeacherLoginPage> createState() => _TeacherLoginPageState();
}

class _TeacherLoginPageState extends State<TeacherLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
              // Navigate to Teacher Dashboard (replace this with your route)
              //Navigator.pushReplacementNamed(context, '/teacher-home');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل الدخول بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              context.pushReplacement(  AppRoutes.layoutScreen);
            }
          },
          builder: (context, state) {
            final textStyles = AppTextStyles(context);

            return Padding(
              padding: AppSize.defaultPadding,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.logo, height: 150),
                        AppSize.verticalSpace(16),
                        Text(
                          'مرحباً أستاذ محمد 👋',
                          style: textStyles.body.copyWith(
                             fontSize: 20,
                          ),
                        ),
                        AppSize.verticalSpace(8),
                        Text(
                          'يرجى تسجيل الدخول للمتابعة إلى لوحة التحكم.',
                          style: textStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppSize.verticalSpace(32),
                        GradientTextField(
                          controller: emailController,
                          hintText: 'البريد الإلكتروني',
                          prefix: Icons.email,
                          validator:
                              (value) =>
                                  value != null && value.contains('@')
                                      ? null
                                      : 'أدخل بريد صحيح',
                        ),
                        AppSize.verticalSpace(16),
                        GradientTextField(
                          controller: passwordController,
                          hintText: 'كلمة المرور',
                          prefix: Icons.lock,
                          isPassword: true,
                          validator:
                              (value) =>
                                  value != null && value.length >= 6
                                      ? null
                                      : 'أدخل كلمة مرور صحيحة',
                        ),
                        AppSize.verticalSpace(32),
                        state is AuthLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().loginAsTeacher(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              },
                              text: 'تسجيل دخول كمدرس',
                            ),
                      ],
                    ),
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
