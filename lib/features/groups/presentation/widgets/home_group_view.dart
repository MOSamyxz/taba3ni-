import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/config/routes/app_routes.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/core/utils/arabic_to%20_english_number.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:taba3ni/features/auth/presentation/cubit/auth_state.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/presentation/widgets/groups_card_item.dart';
import 'package:taba3ni/features/groups/presentation/widgets/groups_welcome_card.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';

class HomeGroupPageView extends StatelessWidget {
  const HomeGroupPageView({
    super.key,
    required this.r,
    required this.textStyle,
    required this.groups,
  });

  final Responsive r;
  final AppTextStyles textStyle;
  final List<GroupEntity> groups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: r.padding(3),
        vertical: r.padding(2),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeGroupTop(r: r, textStyle: textStyle)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final todayEnglishDay =
                    Utils.englishDays[DateTime.now().weekday - 1];
                final todayGroups =
                    groups.where((group) {
                      return group.schedule.any(
                        (entry) => entry.day == todayEnglishDay,
                      );
                    }).toList();
                final group = todayGroups[index];

                return GroupsCardItem(group: group, r: r, textStyle: textStyle);
              },
              childCount:
                  groups.where((group) {
                    final todayEnglishDay =
                        Utils.englishDays[DateTime.now().weekday - 1];
                    return group.schedule.any(
                      (entry) => entry.day == todayEnglishDay,
                    );
                  }).length,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeGroupTop extends StatelessWidget {
  const HomeGroupTop({super.key, required this.r, required this.textStyle});

  final Responsive r;
  final AppTextStyles textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTopBar(
          r: r,
          textStyle: textStyle,
          title: ' لوحة التحكم',
          icon: Icons.dashboard_customize,
          trailing: BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLogOut) {
                  context.go(AppRoutes.authGate);
                }
              },
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await context.read<AuthCubit>().logoutUser();
                  },
                );
              },
            ),
          ),
        ),
        AppSize.verticalSpace(r.hp(2)),
        GroupsWelcomeCard(r: r, textStyle: textStyle),
        Divider(thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
