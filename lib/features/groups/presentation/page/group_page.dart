import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GroupCubit>()..loadGroups(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المجموعات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await context.push(AppRoutes.addGroup);

                if (result == true && context.mounted) {
                  context.read<GroupCubit>().loadGroups();
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            if (state is GroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupError) {
              return Center(child: Text(state.message));
            } else if (state is GroupLoaded) {
              if (state.groups.isEmpty) {
                return const Center(child: Text('لا توجد مجموعات حتى الآن.'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.groups.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final group = state.groups[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        group.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('عدد أيام ${group.schedule.length}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Navigate to GroupDetailsPage(group.id)
                      },
                    ),
                  );
                },
              );
            } else {
              return const SizedBox(); // حالة GroupInitial
            }
          },
        ),
      ),
    );
  }
}
