import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/group_students/presentation/cubit/group_student_cubit.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupStudentsCubit, GroupStudentsState>(
      builder: (context, state) {
        if (state is GroupStudentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupStudentsError) {
          return Center(child: Text(state.message));
        } else if (state is GroupStudentsLoaded) {
          if (state.students.isEmpty) {
            return const Center(child: Text('لا توجد طلاب في هذه المجموعة.'));
          }
    
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final student = state.students[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text('الرقم: ${student.parentPhone}'),
              );
            },
          );
        }
        return const Placeholder();
      },
    );
  }
}
