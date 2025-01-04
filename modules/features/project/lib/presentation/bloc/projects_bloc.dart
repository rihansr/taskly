import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import '../../domain/models/project_model.dart';
import '../../domain/usecases/all_projects_usecase.dart';
import '../../domain/usecases/create_project_usecase.dart';
import '../../domain/usecases/delete_project_usecase.dart';
import '../../domain/usecases/single_project_usecase.dart';
import '../../domain/usecases/update_project_usecase.dart';
part 'projects_event.dart';
part 'projects_state.dart';
part 'projects_bloc.freezed.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  late AllProjectsUseCase _allProjectsUseCase;
  late SingleProjectUseCase _singleProjectUseCase;
  late CreateProjectUseCase _addProjectUseCase;
  late UpdateProjectUseCase _updateProjectUseCase;
  late DeleteProjectUseCase _deleteProjectUseCase;

  ProjectsBloc.projects(
    this._allProjectsUseCase,
  ) : super(const ProjectsState()) {
    on<ProjectsEvent>((events, emit) async {
      await events.mapOrNull(
        allProjects: (event) async => await _allProjects(event, emit),
      );
    });
  }

  ProjectsBloc(
    this._addProjectUseCase,
    this._singleProjectUseCase,
    this._updateProjectUseCase,
    this._deleteProjectUseCase,
  ) : super(const _ProjectsState()) {
    on<ProjectsEvent>((events, emit) async {
      await events.mapOrNull(
        projectDetails: (event) async => await _projectDetails(event, emit),
        addProject: (event) async => await _addProject(event, emit),
        updateProject: (event) async => await _updateProject(event, emit),
        deleteProject: (event) async => await _deleteProject(event, emit),
      );
    });
  }

  _allProjects(_AllProjects event, Emitter<ProjectsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _allProjectsUseCase.invoke();
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (projects) => emitter(
        state.copyWith(
          status: Status.success,
          projects: projects,
        ),
      ),
    );
  }

  _projectDetails(_ProjectDetails event, Emitter<ProjectsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _singleProjectUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (project) => emitter(
        state.copyWith(
          status: Status.success,
          project: project,
        ),
      ),
    );
  }

  _addProject(_AddProject event, Emitter<ProjectsState> emitter) async {
    emitter(state.copyWith(status: Status.creating));
    final result = await _addProjectUseCase.invoke(
      {
        'name': event.name,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (project) => emitter(
        state.copyWith(
          status: Status.success,
          project: project,
          projects: state.projects..add(project),
        ),
      ),
    );
  }

  _updateProject(_UpdateProject event, Emitter<ProjectsState> emitter) async {
    emitter(state.copyWith(status: Status.updating));
    final result = await _updateProjectUseCase.invoke(event.project);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (project) => emitter(
        state.copyWith(
          status: Status.success,
          project: project,
          projects: state.projects
              .map((e) => e.id == project.id ? project : e)
              .toList(),
        ),
      ),
    );
  }

  _deleteProject(_DeleteProject event, Emitter<ProjectsState> emitter) async {
    emitter(state.copyWith(status: Status.deleting));
    final result = await _deleteProjectUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                projects: state.projects
                    .where((element) => element.id != event.id)
                    .toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }
}
