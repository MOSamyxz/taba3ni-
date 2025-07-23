import 'package:flutter/material.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/features/groups/presentation/widgets/group_page_bloc_builder.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget(
          builder: (context, r) {
            return GroupPageBLocBuilder(r: r);
          },
        ),
      ),
    );
  }
}

