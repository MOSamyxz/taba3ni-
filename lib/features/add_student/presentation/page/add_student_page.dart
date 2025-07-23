import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/add_student/presentation/cubit/add_student_cubit.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';
import 'package:taba3ni/features/shaerd_widgets/gradiant_text_field.dart';

class AddStudentPage extends StatelessWidget {
  final String groupId;
  const AddStudentPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddStudentCubit>(),
      child: Scaffold(
        body: BlocConsumer<AddStudentCubit, AddStudentState>(
          listener: (context, state) async {
            if (state is AddStudentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is AddStudentSubmitted) {
              await context.read<AddStudentCubit>().addStudent(state.student);
              if (context.mounted) context.pop(true);
            }
          },
          builder: (context, state) {
            var textStyle = AppTextStyles(context);

            final cubit = context.read<AddStudentCubit>();

            return ResponsiveWidget(
              builder: (context, r) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: cubit.formKey,
                    child: ListView(
                      children: [
                        CustomTopBar(
                          r: r,
                          textStyle: textStyle,
                          title: ' إضافة طالب',
                          icon: Icons.person_add,
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () => context.pop(true),
                          ),
                        ),
                        AppSize.verticalSpace(r.hp(2)),
                        GradientTextField(
                          controller: cubit.nameController,
                          hintText: 'اسم الطالب',
                          prefix: Icons.person,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'مطلوب'
                                      : null,
                        ),
                        AppSize.verticalSpace(r.hp(2)),
                        GradientTextField(
                          controller: cubit.userNameController,
                          hintText: 'اسم المستخدم بالانجليزية',
                          prefix: Icons.person,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'مطلوب'
                                      : null,
                        ),

                        AppSize.verticalSpace(r.hp(2)),
                        GradientTextField(
                          controller: cubit.parentPhoneController,
                          hintText: 'رقم ولي الامر',
                          prefix: Icons.phone,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'مطلوب'
                                      : null,
                        ),

                        AppSize.verticalSpace(r.hp(2)),
                        GradientTextField(
                          controller: cubit.phoneController,
                          hintText: 'رقم الطالب',
                          prefix: Icons.phone,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'مطلوب'
                                      : null,
                        ),

                        AppSize.verticalSpace(r.hp(2)),
                        CustomButton(
                          onPressed: () {
                            cubit.submit(groupId);
                          },
                          text: 'إضافة الطالب',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
