import 'package:core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/task_model.dart';

class AddTaskView extends StatefulWidget {
  final String projectId;
  final String sectionId;

  const AddTaskView({
    super.key,
    required this.projectId,
    required this.sectionId,
  });

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  late TextEditingController _descriptionDateController;
  late TaskModel _task;

  @override
  void initState() {
    _contentController = TextEditingController();
    _descriptionDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _descriptionDateController.dispose();
    super.dispose();
  }

  _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        TaskModel(
          projectId: widget.projectId,
          sectionId: widget.sectionId,
          content: _contentController.text,
          description: _descriptionDateController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            AppBar(
              title: const Text('Add New Task'),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              key: const Key('task_name_field_key'),
              controller: _contentController,
              title: 'Content',
              autoValidate: true,
              textCapitalization: TextCapitalization.words,
              onFieldSubmitted: (_) => _proceed(),
              validator: (value) => validator.validateField(
                value,
                field: 'Content',
              ),
            ),
            TextFieldWidget(
              key: const Key('task_name_field_key'),
              controller: _descriptionDateController,
              title: 'Description',
              autoValidate: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onFieldSubmitted: (_) => _proceed(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('add_task_button_key'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () => _proceed(),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
