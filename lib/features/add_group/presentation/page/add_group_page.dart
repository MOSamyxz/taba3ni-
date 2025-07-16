// lib/features/groups/presentation/page/add_group_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/features/add_group/presentation/cubit/add_group_cubit.dart';
 

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddGroupCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('إضافة مجموعة')),
        body: BlocConsumer<AddGroupCubit, AddGroupState>(
          listener: (context, state) async {
            if (state is AddGroupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            } else if (state is AddGroupSubmitted) {
              await context.read<AddGroupCubit>().addGroup(state.group);
              if(context.mounted) context.pop(true);  
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddGroupCubit>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: cubit.nameController,
                    decoration: const InputDecoration(labelText: 'اسم المجموعة'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: cubit.notesController,
                    decoration: const InputDecoration(labelText: 'ملاحظات'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  const Text('اختيار الأيام والمواعيد:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...cubit.selectedDays.keys.map((day) {
                    final time = cubit.selectedDays[day];
                    return ListTile(
                      title: Text(day),
                      subtitle: Text(time != null ? 'الساعة: ${time.format(context)}' : 'لم يتم اختيار الوقت'),
                      trailing: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => cubit.pickTime(day, context),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => cubit.submit(context),
                    child: const Text('حفظ المجموعة'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
