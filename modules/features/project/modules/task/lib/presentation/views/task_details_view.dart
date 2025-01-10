import 'package:core/styles/dimen.dart';
import 'package:core/utils/enums.dart';
import 'package:core/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/due_model.dart';
import '../../domain/models/duration_model.dart';
import '../../domain/models/task_tracker_model.dart';
import '../../domain/usecases/close_task_usecase.dart';
import '../../domain/usecases/reopen_task_usecase.dart';
import '../../domain/usecases/single_task_usecase.dart';
import '../../domain/models/task_model.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../bloc/tasks_bloc.dart';
import '../components/time_tracker_widget.dart';
import 'comments_view.dart';

class TaskDetailsView extends StatefulWidget {
  final TaskModel task;

  const TaskDetailsView({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final _tasksBloc = TasksBloc.single(
    sl<SingleTaskUseCase>(),
    sl<CreateTaskUseCase>(),
    sl<UpdateTaskUseCase>(),
    sl<CloseTaskUseCase>(),
    sl<ReopenTaskUseCase>(),
    sl<DeleteTaskUseCase>(),
  );
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;
  late DateTime? _dueDate;
  late Duration _duration;
  late TaskModel _task;
  late TaskTrackerModel? _taskTracker;

  @override
  void initState() {
    _setTask(widget.task);
    _setTaskTracker();
    _tasksBloc.add(TasksEvent.taskDetails(id: _task.id ?? '0'));
    super.initState();
  }

  _setTask(TaskModel task) {
    _task = widget.task;
    _titleController = TextEditingController(text: task.content);
    _descriptionController = TextEditingController(text: task.description);
    _dueDate = task.due?.date;
    _dueDateController = TextEditingController(text: task.due?.string);
    _duration = Duration(seconds: task.duration?.amount ?? 0);
  }

  _setTaskTracker() {
    final data = sl<SharedPrefs>().getTaskTracker(_task.id!);
    _taskTracker = data == null ? null : TaskTrackerModel.fromJson(data);
    if (_taskTracker != null) {
      int seconds = DateTime.now().difference(_taskTracker!.time).inSeconds;
      _duration = Duration(seconds: _duration.inSeconds + seconds);
    }
  }

  _datePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: _task.due?.date ?? DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (date != null) {
      setState(() {
        _dueDate = date;
        _dueDateController.text = utils.DateFormat.yMMMMEEEEd().format(date);
      });
    }
  }

  _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        _task.copyWith(
          content: _titleController.text,
          description: _descriptionController.text,
          due: _dueDate == null ? null : DueModel.fromDate(_dueDate!),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      onPopInvokedWithResult: (_, task) {
        if (task != widget.task) {
          context.read<TasksBloc>().add(
                TasksEvent.updateTask(task: task as TaskModel),
              );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _proceed,
          ),
          actions: [
            TimeTracker(
              duration: _duration,
              initiallyStart: _taskTracker != null,
              onStart: () {
                if (_taskTracker == null) {
                  _taskTracker = TaskTrackerModel(
                    id: _task.id!,
                    time: DateTime.now(),
                  );
                  sl<SharedPrefs>()
                      .setTaskTracker(_task.id!, _taskTracker!.toJson());
                }
              },
              onStop: (duration) {
                _duration = duration;
                _taskTracker = null;
                sl<SharedPrefs>().setTaskTracker(_task.id!, null);
                _task = _task.copyWith(
                  duration: DurationModel(
                    amount: duration.inSeconds,
                    unit: 'minute',
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<TasksBloc, TasksState>(
          bloc: _tasksBloc,
          listener: (BuildContext context, TasksState state) {
            if (state.status == Status.success) {
              _setTask(state.task);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                16.0,
                16.0,
                dimen.bottom(16.0),
              ),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldWidget(
                            key: const Key('task_title_field_key'),
                            controller: _titleController,
                            title: 'Title',
                            autoValidate: true,
                            minLines: 1,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            validator: (value) => utils.validator.validateField(
                              value,
                              field: 'Content',
                            ),
                          ),
                          TextFieldWidget(
                            key: const Key('task_description_field_key'),
                            controller: _descriptionController,
                            title: 'Description',
                            autoValidate: true,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 5,
                          ),
                          TextFieldWidget(
                            key: const Key('task_due_field_key'),
                            controller: _dueDateController,
                            title: 'Due Date',
                            onTap: _datePicker,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (_dueDate == null) return;
                                setState(() {
                                  _dueDate = null;
                                  _dueDateController.clear();
                                });
                              },
                              icon: Icon(
                                _dueDate == null
                                    ? Icons.calendar_today
                                    : Icons.clear,
                                size: 18,
                                color: theme.hintColor,
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                body: CommentsView(task: _task),
              ),
            );
          },
        ),
      ),
    );
  }
}
