import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project/domain/models/project_model.dart';
import 'package:section/domain/models/section_model.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:task/domain/models/task_model.dart';
import 'package:core/utils/utils.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const _DashboardState()) {
    on<DashboardEvent>((events, emit) async {
      events.map(
        assignProject: (event) => _allProjects(event, emit),
        addSectionTasks: (event) => _addSectionTasks(event, emit),
        reset: (event) => emit(const _DashboardState()),
      );
    });
  }

  _allProjects(_AssignProject event, Emitter<DashboardState> emitter) {
    emitter(state.copyWith(currentProject: event.project));
  }

  _addSectionTasks(_AddSectionTasks event, Emitter<DashboardState> emitter) {
    final sectionTasks = {
      SectionModel(
        projectId: state.currentProject?.id,
        name: 'Backlog',
      ): <TaskModel>[], //
      ...{for (var section in event.sections) section: <TaskModel>[]}
    };

    for (final task in event.tasks) {
      final section = event.sections.firstWhereOrNull(
        (section) => section.id == task.sectionId,
      );
      if(section == null){
        sectionTasks[sectionTasks.keys.first]?.add(task);
      } else {
        sectionTasks[section]?.add(task);
      }
    }
    emitter(state.copyWith(sectionTasks: sectionTasks));
  }
}
