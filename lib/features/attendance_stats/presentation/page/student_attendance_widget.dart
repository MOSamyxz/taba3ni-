import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/attendance_stats/presentation/cubit/student_attendance_cubit.dart';
 
class StudentAttendanceStatsWidget extends StatelessWidget {
 

  const StudentAttendanceStatsWidget({
    super.key,
 
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentAttendanceCubit, StudentAttendanceState>(
          builder: (context, state) {
            if (state is StudentAttendanceStatsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentAttendanceStatsError) {
              return Center(child: Text('حدث خطأ: ${state.error}'));
            } else if (state is StudentAttendanceStatsLoaded) {
              final statsList = state.stats;

              if (statsList.isEmpty) {
                return const Center(child: Text('لا يوجد طلاب'));
              }

              return ListView.builder(
                itemCount: statsList.length,
                itemBuilder: (context, index) {
                  final stat = statsList[index];
                  final total = stat.presentCount + stat.absentCount;
                  final percent = total > 0 ? (stat.presentCount / total * 100).toStringAsFixed(1) : '0';

                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                     
                      title: Text(stat.studentName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('✅ الحضور: ${stat.presentCount}'),
                          Text('❌ الغياب: ${stat.absentCount}'),
                          Text('📊 نسبة الحضور: $percent%'),
                        ],
                      ),
                      trailing: CircularProgressIndicator(
                        value: total > 0 ? stat.presentCount / total : 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        backgroundColor: Colors.grey.shade300,
                        strokeWidth: 5,
 
                       ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.shrink(); // حالة مبدئية
            }
          },
        );
  }
}
