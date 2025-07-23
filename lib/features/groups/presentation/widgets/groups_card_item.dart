import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/core/utils/group_utils.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/presentation/cubit/group_cubit.dart';

class GroupsCardItem extends StatelessWidget {
  const GroupsCardItem({
    super.key,
    required this.group,
    required this.r,
    required this.textStyle,
  });

  final GroupEntity group;
  final Responsive r;
  final AppTextStyles textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.groupDetails, extra: group.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: (r.padding(2)),
          vertical: r.padding(3),
        ),
        width: r.wp(90),
        child: Stack(children: [_detailsLabel( context), _gradeLabel()]),
      ),
    );
  }

  Align _detailsLabel(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: r.padding(2),
          horizontal: r.padding(4),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getImage(group.grade)),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withAlpha(50),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(r.radius(5)),
        ),
        width: r.wp(85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  group.name,
                  style: textStyle.heading2.copyWith(
                    fontSize: r.sp(6),
                    color: Colors.black,
                  ),
                ),
                Text(
                  'المواعيد:',
                  style: textStyle.body.copyWith(
                    fontSize: r.sp(5),
                    color: Colors.black,
                  ),
                ),
                ...group.schedule.map(
                  (entry) => Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: r.radius(6),
                          ),
                        ),

                        TextSpan(
                          text: " ${entry.day} - ${entry.time}",
                          style: textStyle.heading3.copyWith(
                            fontSize: r.sp(5),

                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(Icons.note_outlined, size: r.radius(6)),
                      ),
                      TextSpan(
                        text: " ${group.notes}",
                        style: textStyle.heading3.copyWith(
                          fontSize: r.sp(5),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                final result = await context.push(
                  AppRoutes.addGroup,
                  extra: group,
                );

                if (result == true && context.mounted) {
                  context.read<GroupCubit>().loadGroups();
                }
              },
              icon: Icon(
                Icons.edit_note_outlined,
                color: Colors.black,
                size: r.radius(6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _gradeLabel() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(r.padding(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radius(5)),
          color: getCardColor(group.grade),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withAlpha(50),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          getGrade(group.grade),
          style: textStyle.heading3.copyWith(
            fontSize: r.sp(5),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
