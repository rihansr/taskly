import 'package:core/styles/dimen.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/models/project_model.dart';
import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:project/presentation/views/add_project_view.dart';
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
            onPressed: () => showModalBottomSheet(
              context: context,
              enableDrag: true,
              showDragHandle: true,
              shape: style.defaultBottomSheetShape,
              builder: (_) => const AddProjectView(),
            ).then(
              (project) {
                if (project != null) {
                  context.read<ProjectsBloc>().add(
                        ProjectsEvent.addProject(
                          name: (project as ProjectModel?)?.name ?? '',
                        ),
                      );
                }
              },
            ),
            style: ElevatedButton.styleFrom(
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
