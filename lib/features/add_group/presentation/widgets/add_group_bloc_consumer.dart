import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/add_group/presentation/cubit/add_group_cubit.dart';
import 'package:taba3ni/features/add_group/presentation/widgets/add_group_page_view.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';

class AddGroupBlocConsumer extends StatelessWidget {
  const AddGroupBlocConsumer({super.key, required this.r, this.group});
  final Responsive r;
final GroupEntity? group;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddGroupCubit, AddGroupState>(
      listener: (context, state) async {
        if (state is AddGroupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        } else if (state is GroupSubmitted) {
          if (context.read<AddGroupCubit>().isEditMode) {
            await context.read<AddGroupCubit>().updateGroup(state.group);
            if (context.mounted) context.pop(true);
          } else {
            await context.read<AddGroupCubit>().addGroup(state.group);
            if (context.mounted) context.pop(true);
          }
        }
      },
      builder: (context, state) {
        final cubit = context.watch<AddGroupCubit>();
        var textStyle = AppTextStyles(context);
        return AddGroupPageView(r: r, textStyle: textStyle, cubit: cubit,group:  group);
      },
    );
  }
}
