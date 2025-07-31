import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';
import 'package:taba3ni/features/groups/presentation/widgets/home_group_view.dart';

class HomeGroupPageBLocBuilder extends StatelessWidget {
  const HomeGroupPageBLocBuilder({super.key, required this.r});
  final Responsive r;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        var textStyle = AppTextStyles(context); 
        if (state is GroupLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupError) {
          return Center(child: Text(state.error));
        } else if (state is GroupLoaded) {
          if (state.groups.isEmpty) {
            return Column(
              children: [
                HomeGroupTop(r: r, textStyle: textStyle),
                const Center(child: Text('لا توجد مجموعات حتى الآن.')),
              ],
            );
          }
          List<GroupEntity> groups = state.groups;
          return HomeGroupPageView(r: r, textStyle: textStyle, groups: groups);
        } else {
          return const SizedBox(); // حالة GroupInitial
        }
      },
    );
  }
}
