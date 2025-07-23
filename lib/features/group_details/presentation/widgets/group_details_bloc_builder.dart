import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/group_details/presentation/cubit/cubit/group_details_cubit.dart';
import 'package:taba3ni/features/group_details/presentation/widgets/group_details_view.dart';

class GroupDetailsBlocBuilder extends StatelessWidget {
  const GroupDetailsBlocBuilder({super.key, required this.r});
  final Responsive r;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
      builder: (context, state) {
        if (state is GroupDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupDetailsError) {
          return Center(child: Text(state.error));
        } else if (state is GroupDetailsLoaded) {
          final group = state.group;
          var textStyle = AppTextStyles(context);
          return GroupDetailsView(group: group, r: r, textStyle: textStyle);
        }
        return const Placeholder();
      },
    );
  }
}
