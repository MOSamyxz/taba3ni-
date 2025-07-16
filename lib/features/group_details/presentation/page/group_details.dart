import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/features/group_details/presentation/cubit/cubit/group_details_cubit.dart';
import 'package:taba3ni/features/group_students/presentation/cubit/group_student_cubit.dart';
import 'package:taba3ni/features/group_students/presentation/page/student_list_widget.dart';

class GroupDetailsPage extends StatelessWidget {
  final String groupId;
  const GroupDetailsPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GroupDetailsCubit>()..loadGroup(groupId),
      child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
        builder: (context, state) {
          if (state is GroupDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is GroupDetailsLoaded) {
            final group = state.group;
            return Scaffold(
              appBar: AppBar(
                title: Text(group.name),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () {
                      // TODO: Navigate to EditGroupPage(group.id)
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.event),
                    onPressed: () {
                      // TODO: Show confirmation dialog and delete group
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'الجدول:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        ...group.schedule.map(
                          (entry) => Column(
                            children: [
                              Text(entry.day),
                              Text('الساعة: ${entry.time}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    BlocProvider(
                      create:
                          (_) =>
                              sl<GroupStudentsCubit>()
                                ..loadStudentsByGroupId(groupId),
                      child: const StudentListWidget(),
                    ),

                    if (group.notes?.isNotEmpty ?? false)
                      Text('ملاحظات: ${group.notes!}'),
                  ],
                ),
              ),
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}
