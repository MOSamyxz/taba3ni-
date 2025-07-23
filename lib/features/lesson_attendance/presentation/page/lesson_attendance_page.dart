import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/lesson_attendance/domain/entity/student_attendance_entity.dart';
import 'package:taba3ni/features/lesson_attendance/presentation/cubit/lessons_attendance_cubit.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';

class LessonAttendancePage extends StatelessWidget {
  final String lessonId;
  final String groupId;
  const LessonAttendancePage({
    super.key,
    required this.lessonId,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<LessonsAttendanceCubit>()
                ..getLessonsAttendance(lessonId, groupId),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveWidget(
            builder: (context, r) {
              return BlocBuilder<
                LessonsAttendanceCubit,
                LessonsAttendanceState
              >(
                builder: (context, state) {
                  if (state is LessonsAttendanceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LessonsAttendanceError) {
                    return Center(child: Text(state.error));
                  } else if (state is LessonsAttendanceLoaded) {
                    List<StudentAttendanceEntity> lessonAttendanceStudents =
                        state.lessonAttendanceStudents;
                    var textStyle = AppTextStyles(context);

                    return Scaffold(
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: r.padding(3),
                          vertical: r.padding(2),
                        ),
                        child: Column(
                          children: [
                            CustomTopBar(
                              r: r,
                              textStyle: textStyle,
                              title: ' سجل الحضور',
                              icon: Icons.group,
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () => context.pop(true),
                              ),
                            ),
                            AppSize.verticalSpace(r.hp(2)),
                            Expanded(
                              child: ListView.separated(
                                itemCount: lessonAttendanceStudents.length,
                                separatorBuilder:
                                    (context, index) =>
                                        AppSize.verticalSpace(r.hp(2)),
                                itemBuilder: (context, index) {
                                  final student =
                                      lessonAttendanceStudents[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : AppColors.darkBackground,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(student.studentName),
                                      trailing: Icon(
                                        student.isPresent
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color:
                                            student.isPresent
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Placeholder();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
