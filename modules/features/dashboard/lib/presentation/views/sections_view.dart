import 'package:core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:shared/presentation/bloc/bloc.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: BlocConsumer<SectionsBloc, SectionsState>(
            bloc: context.read<SectionsBloc>(),
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Container();
              } else if (state.status == Status.success) {
                return Container();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
