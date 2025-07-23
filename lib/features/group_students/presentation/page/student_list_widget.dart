import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/group_details/presentation/cubit/cubit/group_details_cubit.dart';
import 'package:taba3ni/features/group_students/presentation/cubit/group_student_cubit.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

class StudentListWidget extends StatelessWidget {
  final String groupId;
  final Responsive r;

  const StudentListWidget({required this.groupId, super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupStudentsCubit, GroupStudentsState>(
      builder: (context, state) {
        if (state is GroupStudentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupStudentsError) {
          return Center(child: Text(state.error));
        } else if (state is GroupStudentsLoaded) {
          if (state.students.isEmpty) {
            return Column(
              children: [
                AddStudentAndLessonButtons(groupId: groupId, r: r, students: [],),
                const Center(child: Text('لا توجد طلاب في هذه المجموعة.')),
              ],
            );
          }
                    var textStyle = AppTextStyles(context);

          return Column(
            children: [
              AddStudentAndLessonButtons(groupId: groupId, r: r, students: state.students,),
              Divider(thickness: 1, color: Colors.grey.shade300),
              Expanded(
                child: ListView.separated(
                  itemCount: state.students.length,
                  separatorBuilder: (context, index) => AppSize.verticalSpace(r.hp(2)),
                  itemBuilder: (context, index) {
                    final student = state.students[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.all(10),
                      decoration: 
                          BoxDecoration(
                            color:Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(10),
                           boxShadow:  [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            )
                          ]),
                      child: ListTile(
                           title: Text(student.name, style: textStyle.heading2.copyWith(fontSize: r.sp(5)),),
                        subtitle: Text('رقم ولي الأمر: ${student.parentPhone}',style: textStyle.bodySecondary.copyWith(fontSize: r.sp(4))),
                        trailing: IconButton(
                          icon:   Icon(Icons.delete,color: AppColors.primary,),
                          onPressed: () async {
                            context.read<GroupStudentsCubit>().deleteStudent(
                              student.id,
                              groupId,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Placeholder();
      },
    );
  }
}

class AddStudentAndLessonButtons extends StatelessWidget {
  const AddStudentAndLessonButtons({
    super.key,
    required this.groupId,
    required this.r,
     required this.students,
  });

  final String groupId;
  final Responsive r;
final List<StudentsEntity> students;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () async {
              final result = await context.push(
                AppRoutes.addStudent,
                extra: groupId,
              );
              if (result == true && context.mounted) {
                context.read<GroupDetailsCubit>().loadGroup(groupId);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.person_add,color: Colors.white), Text('إضافة طالب',style: TextStyle(color: Colors.white),)],
            ),
          ),
        ),
        AppSize.horizontalSpace(r.wp(3)),
        if(students.isNotEmpty)
        Expanded(
          child: CustomButton(
            onPressed: () async {
              final result = await context.push(
                AppRoutes.startLesson,
                extra: {
                          'groupId':  groupId,
                          'students': students,
                        },
              );
              if (result == true && context.mounted) {
                context.read<GroupDetailsCubit>().loadGroup(groupId);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.event ,color: Colors.white), Text('إضافة حصة' ,style: TextStyle(color: Colors.white),)],
            ),
          ),
        ),
      ],
    );
  }
}
