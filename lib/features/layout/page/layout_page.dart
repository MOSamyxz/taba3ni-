import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/features/groups/presentation/page/group_page.dart';
import 'package:taba3ni/features/groups/presentation/page/home_groups.dart';
import 'package:taba3ni/features/layout/cubit/layout_cubit.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  final _pages = const [HomeGroupPage(),GroupPage(), Scaffold()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: _pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => context.read<LayoutCubit>().changeTab(index),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.disabled,
              items:  [
                BottomNavigationBarItem(
                  icon: Icon(Icons.today),
                  label: 'حصص اليوم',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'المجموعات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'الاعدادات',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
