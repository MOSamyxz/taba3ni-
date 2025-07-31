import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
 import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';

class GroupsWelcomeCard extends StatelessWidget {
  const GroupsWelcomeCard({
    super.key,
    required this.r,
    required this.textStyle,
  });

  final Responsive r;
  final AppTextStyles textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.padding(2)),
      padding: EdgeInsets.symmetric(
        vertical: r.padding(1),
        horizontal: r.padding(4),
      ),
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(r.radius(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحبا بك,',
                style: textStyle.heading3.copyWith(
                  fontSize: r.sp(6),
                ),
              ),
              Text(
                'أستاذ محمد',
                style: textStyle.heading2.copyWith(
                  fontSize: r.sp(8),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.group_add_rounded),
            iconSize: r.radius(8),
            onPressed: () async {
              final result = await context.push(
                AppRoutes.addGroup,
              );
        
              if (result == true && context.mounted) {
                context.read<GroupCubit>().loadGroups();
              }
            },
          ),
        ],
      ),
    );
  }
}
