import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/features/group_details/presentation/cubit/cubit/group_details_cubit.dart';
import 'package:taba3ni/features/group_details/presentation/widgets/group_details_bloc_builder.dart';

class GroupDetailsPage extends StatelessWidget {
  final String groupId;
  const GroupDetailsPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GroupDetailsCubit>()..loadGroup(groupId),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveWidget(
            builder: (context, r) {
              return GroupDetailsBlocBuilder(r: r);
            },
          ),
        ),
      ),
    );
  }
}

 