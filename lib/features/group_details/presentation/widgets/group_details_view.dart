import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/attendance_stats/presentation/cubit/student_attendance_cubit.dart';
import 'package:taba3ni/features/attendance_stats/presentation/page/student_attendance_widget.dart';
import 'package:taba3ni/features/group_details/presentation/widgets/custom_tab_bar.dart';
import 'package:taba3ni/features/group_lesson/presentation/cubit/group_lessons_cubit.dart';
import 'package:taba3ni/features/group_lesson/presentation/page/lesson_list_widget.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/group_students/presentation/cubit/group_student_cubit.dart';
import 'package:taba3ni/features/group_students/presentation/page/student_list_widget.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({
    super.key,
    required this.group,
    required this.r,
    required this.textStyle,
  });

  final GroupEntity group;
  final Responsive r;
  final AppTextStyles textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: r.padding(3),
        vertical: r.padding(2),
      ),      child: Column(
        children: [
              CustomTopBar(
                 r: r, 
                 textStyle: textStyle, 
                 title: ' ${group.name}',
                 icon: Icons.group,
                  trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => context.pop(true),
            ),
                 ),               AppSize.verticalSpace(r.hp(2)),

          Expanded(
            child: StackOver(
              height: r.hp(7),
              tabs: [
                Tab(child: _tabWidget(
                  icon: Icons.person,
                  text: 'الطلاب',
                 ),),
                Tab(child: _tabWidget(
                  icon: Icons.menu_book,
                  text: 'الحصص',
                 ),),
                Tab(child: _tabWidget(
                  icon: Icons.analytics,
                  text: 'سجل الحضور',
                 ),),
              ],
              children: [
                GroupStudentListWidget(groupId: group.id,r:r),
                GroupLessonListWidget(groupId: group.id ,r:r), 
                AttendanceReportWidget(groupId: group.id),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _tabWidget({
  required  IconData  icon,
  required  String  text,
 
  }) {
    return Column(
          children: [
          Icon(icon,size: r.sp(6),color: Colors.white,),
             Text(
              text,
              style: textStyle.heading2.copyWith(
                color: Colors.white,
                fontSize: r.sp(4)),
            ),
          ],
        );
  }
}

class AttendanceReportWidget extends StatelessWidget {
  const AttendanceReportWidget({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StudentAttendanceCubit>()..loadStats(groupId),
      child: const StudentAttendanceStatsWidget(),
    );
  }
}

class GroupLessonListWidget extends StatelessWidget {
  const GroupLessonListWidget({super.key, required this.groupId, required this.r});

  final String groupId;
  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GroupLessonsCubit>()..getGroupLessons(groupId),
      child:   LessonListWidget(r:r),
    );
  }
}

class GroupStudentListWidget extends StatelessWidget {
  const GroupStudentListWidget({super.key, required this.groupId,required this.r});

  final String groupId;
final Responsive r;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocProvider(
            create:
                (_) =>
                    sl<GroupStudentsCubit>()..loadStudentsByGroupId(groupId),
            child: StudentListWidget(groupId: groupId,r:r),
          ),
        ),
      ],
    );
  }
}