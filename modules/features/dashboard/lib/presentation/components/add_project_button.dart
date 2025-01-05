import 'package:core/styles/dimen.dart';
import 'package:core/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/usecases/create_project_usecase.dart';
import 'package:project/domain/usecases/delete_project_usecase.dart';
import 'package:project/domain/usecases/single_project_usecase.dart';
import 'package:project/domain/usecases/update_project_usecase.dart';
import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/bloc/bloc.dart';

class AddProjectButton extends StatefulWidget {
  final AnimationController animationController;
  const AddProjectButton({
    super.key,
    required this.animationController,
  });

  @override
  State<AddProjectButton> createState() => _AddProjectButtonState();
}

class _AddProjectButtonState extends State<AddProjectButton> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    widthAnimation = Tween<double>(begin: dimen.width * .6, end: 64)
        .animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ProjectsBloc, ProjectsState>(
      bloc: context.read<ProjectsBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<ProjectsBloc>()
                  .add(const ProjectsEvent.addProject(name: 'Test Project'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: state.status == Status.creating
                ? CupertinoActivityIndicator(
                    radius: 12,
                    color: theme.colorScheme.onPrimary,
                  )
                : (widthAnimation.value >= dimen.width * .5)
                    ? const Text('Add Project')
                    : const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
