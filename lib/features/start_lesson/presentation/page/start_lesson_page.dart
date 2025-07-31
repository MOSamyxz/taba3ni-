 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';
import 'package:taba3ni/features/shaerd_widgets/gradiant_text_field.dart';
import 'package:taba3ni/features/start_lesson/presentation/cubit/start_lesson_cubit.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

class StartLessonPage extends StatelessWidget {
  final String groupId;
  final List<StudentsEntity> students;

  const StartLessonPage({
    super.key,
    required this.groupId,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StartLessonCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<StartLessonCubit, StartLessonState>(
            listener: (context, state) {
              if (state is StartLessonSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ تم تسجيل الحصة بنجاح')),
                );
                Navigator.pop(context, true);
              } else if (state is StartLessonError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('❌ ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              var cubit = context.read<StartLessonCubit>();
              var textStyle = AppTextStyles(context);
              return ResponsiveWidget(
                builder: (context, r) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CustomTopBar(
                          r: r,
                          textStyle: textStyle,
                          title: ' إضافة حصة جديدة',
                          icon: Icons.person_add,
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () => context.pop(true),
                          ),
                        ),
                        AppSize.verticalSpace(r.hp(2)),

                        GradientTextField(
                          controller: cubit.topicController,
                          hintText: 'موضوع الحصة',
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تحديد حالة كل طالب:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            itemCount: students.length,
                            separatorBuilder:
                                (_, __) => const  SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final student = students[index];
                              return Container(
                                
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                                child: ListTile(
                                  title: Text(student.name),
                                  trailing: BlocBuilder<
                                    StartLessonCubit,
                                    StartLessonState
                                  >(
                                    buildWhen: (previous, current) {
                                      return current is SetAttenddance &&
                                          current.studentId == student.id;
                                    },
                                    builder: (context, state) {
                                      final currentStatus =
                                          cubit.attendanceMap[student.id] ??
                                          'present';
                                      return DropdownButton<String>(
                                        value: currentStatus,
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'present',
                                            child: Text('✅ حاضر'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'absent',
                                            child: Text('❌ غائب'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          cubit.setAttendance(student.id, value);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<StartLessonCubit, StartLessonState>(
                          builder: (context, state) {
                            return    CustomButton(
                              onPressed: state is StartLessonLoading
                                    ? null
                                    : () => cubit.submit(
                                      groupId: groupId,
                                      students: students,
                                    ),
                              text:
                                  state is StartLessonLoading
                                      ? 'جاري الحفظ...'
                                      : 'حفظ الحصة',
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
/**  ElevatedButton.icon(
                              icon: const Icon(Icons.save),
                              label: Text(
                                state is StartLessonLoading
                                    ? 'جاري الحفظ...'
                                    : 'حفظ الحصة',
                              ),
                              onPressed:
                                  state is StartLessonLoading
                                      ? null
                                      : () => cubit.submit(
                                        groupId: groupId,
                                        students: students,
                                      ),
                            ); */