import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/group_lesson/presentation/cubit/group_lessons_cubit.dart';

class LessonListWidget extends StatelessWidget {
  const LessonListWidget({super.key, required this.r});
  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupLessonsCubit, GroupLessonsState>(
      builder: (context, state) {
        if (state is GroupLessonsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupLessonsError) {
          return Center(child: Text(state.error));
        } else if (state is GroupLessonsLoaded) {
          if (state.lessons.isEmpty) {
            return const Center(child: Text('لا توجد حصص في هذه المجموعة.'));
          }
          var textStyle = AppTextStyles(context);

          return ListView.separated(
            itemCount: state.lessons.length,
            separatorBuilder:
                (context, index) => AppSize.verticalSpace(r.hp(2)),

            itemBuilder: (context, index) {
              final lesson = state.lessons[index];
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
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    lesson.topic ?? 'لا يوجد',
                    style: textStyle.heading2.copyWith(fontSize: r.sp(5)),
                  ),
                  subtitle: Text(
                    'التاريخ: ${DateFormat.yMMMMd().format(lesson.date)}',
                    style: textStyle.bodySecondary.copyWith(fontSize: r.sp(4)),
                  ),
                  trailing: IconButton(
                    icon:   Icon(Icons.arrow_right,size: r.radius(10),),
                    color: AppColors.primary,
                    onPressed: () async {
                      await context.push(
                        AppRoutes.lessonAttendance,
                        extra: {
                          'groupId': lesson.groupId,
                          'lessonId': lesson.id,
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
        return const Placeholder();
      },
    );
  }
}
