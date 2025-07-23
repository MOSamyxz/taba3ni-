
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/config/responsive/responsive_widget.dart';
import 'package:taba3ni/features/add_group/presentation/cubit/add_group_cubit.dart';
import 'package:taba3ni/features/add_group/presentation/widgets/add_group_bloc_consumer.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddGroupCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveWidget(
            builder: (context, r) {
              return AddGroupBlocConsumer(r: r);
            },
          ),
        ),
      ),
    );
  }
}