import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';
import 'package:taba3ni/features/groups/presentation/widgets/group_page_view.dart';

class GroupPageBLocBuilder extends StatelessWidget {
  const GroupPageBLocBuilder({super.key, required this.r});
  final Responsive r;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupError) {
          return Center(child: Text(state.error));
        } else if (state is GroupLoaded) {
          if (state.groups.isEmpty) {
            return const Center(child: Text('لا توجد مجموعات حتى الآن.'));
          }
          var textStyle = AppTextStyles(context);
          List<GroupEntity> groups = state.groups;
          return GroupPageView(r: r, textStyle: textStyle, groups: groups);
        } else {
          return const SizedBox(); // حالة GroupInitial
        }
      },
    );
  }
}