import 'package:core/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import '../../domain/models/task_model.dart';
import '../../domain/usecases/active_tasks_usecase.dart';
import '../../domain/usecases/close_task_usecase.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/reopen_task_usecase.dart';
import '../../domain/usecases/shared_labels_usecase.dart';
import '../../domain/usecases/single_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';
part 'tasks_bloc.freezed.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  late ActiveTasksUseCase _activeTasksUseCase;
  late SharedLabelsUseCase _sharedLabelsUseCase;
  late SingleTaskUseCase _singleTaskUseCase;
  late final CreateTaskUseCase _addTaskUseCase;
  late final UpdateTaskUseCase _updateTaskUseCase;
  late CloseTaskUseCase _closeTaskUseCase;
  late ReopenTaskUseCase _reopenTaskUseCase;
  late final DeleteTaskUseCase _deleteTaskUseCase;

  TasksBloc(
    this._activeTasksUseCase,
    this._sharedLabelsUseCase,
    this._singleTaskUseCase,
    this._addTaskUseCase,
    this._updateTaskUseCase,
    this._closeTaskUseCase,
    this._reopenTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const TasksState()) {
    on<TasksEvent>((events, emit) async {
      await events.map(
        activeTasks: (event) async => await _activeTasks(event, emit),
        sharedLabels: (event) async => await _sharedLabels(event, emit),
        taskDetails: (event) async => await _taskDetails(event, emit),
        addTask: (event) async => await _addTask(event, emit),
        updateTask: (event) async => await _updateTask(event, emit),
        closeTask: (event) async => await _closeTask(event, emit),
        reopenTask: (event) async => await _reopenTask(event, emit),
        deleteTask: (event) async => await _deleteTask(event, emit),
        reset: (event) async => emit(const TasksState()),
      );
    });
  }

  TasksBloc.tasks(this._activeTasksUseCase, this._addTaskUseCase,
      this._updateTaskUseCase, this._deleteTaskUseCase)
      : super(const TasksState()) {
    on<TasksEvent>((events, emit) async {
      await events.mapOrNull(
        activeTasks: (event) async => await _activeTasks(event, emit),
        addTask: (event) async => await _addTask(event, emit),
        updateTask: (event) async => await _updateTask(event, emit),
        deleteTask: (event) async => await _deleteTask(event, emit),
        reset: (event) async => emit(const TasksState()),
      );
    });
  }

  TasksBloc.single(
    this._sharedLabelsUseCase,
    this._singleTaskUseCase,
    this._addTaskUseCase,
    this._updateTaskUseCase,
    this._closeTaskUseCase,
    this._reopenTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const TasksState()) {
    on<TasksEvent>((events, emit) async {
      await events.mapOrNull(
        sharedLabels: (event) async => await _sharedLabels(event, emit),
        taskDetails: (event) async => await _taskDetails(event, emit),
        addTask: (event) async => await _addTask(event, emit),
        updateTask: (event) async => await _updateTask(event, emit),
        closeTask: (event) async => await _closeTask(event, emit),
        reopenTask: (event) async => await _reopenTask(event, emit),
        deleteTask: (event) async => await _deleteTask(event, emit),
        reset: (event) async => emit(const TasksState()),
      );
    });
  }

  _activeTasks(_ActiveTasks event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _activeTasksUseCase.invoke(
      {
        'project_id': event.projectId,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (tasks) => emitter(
        state.copyWith(
          status: Status.success,
          tasks: tasks,
        ),
      ),
    );
  }

  _sharedLabels(_SharedLabels event, Emitter<TasksState> emitter) async {
    final result = await _sharedLabelsUseCase.invoke();
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.initial,
        errorMessage: failure.errorMessage,
      )),
      (labels) => emitter(
        state.copyWith(
          status: Status.success,
          labels: labels,
        ),
      ),
    );
  }

  _taskDetails(_TaskDetails event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _singleTaskUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (task) => emitter(
        state.copyWith(
          status: Status.success,
          task: task,
        ),
      ),
    );
  }

  _addTask(_AddTask event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.creating));
    final result = await _addTaskUseCase.invoke(
      event.task.toJson()..removeWhere((key, value) => value == null),
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (task) => emitter(
        state.copyWith(
          status: Status.success,
          task: task,
          tasks: [...state.tasks, task],
        ),
      ),
    );
  }

  _updateTask(_UpdateTask event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.updating));
    final result = await _updateTaskUseCase.invoke(event.task);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (task) => emitter(
        state.copyWith(
          status: Status.success,
          task: task,
          tasks: state.tasks.map((e) => e.id == task.id ? task : e).toList(),
        ),
      ),
    );
  }

  _closeTask(_CloseTask event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.closing));
    final result = await _closeTaskUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                task: state.task.copyWith(isCompleted: true),
                tasks: state.tasks
                    .map((e) =>
                        e.id == event.id ? e.copyWith(isCompleted: true) : e)
                    .toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }

  _reopenTask(_ReopenTask event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.reopening));
    final result = await _reopenTaskUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                task: state.task.copyWith(isCompleted: false),
                tasks: state.tasks
                    .map((e) =>
                        e.id == event.id ? e.copyWith(isCompleted: false) : e)
                    .toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }

  _deleteTask(_DeleteTask event, Emitter<TasksState> emitter) async {
    emitter(state.copyWith(status: Status.deleting));
    final result = await _deleteTaskUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                tasks: state.tasks.where((e) => e.id != event.id).toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }
}
