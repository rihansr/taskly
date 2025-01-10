import 'package:core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/task_model.dart';

class AddTaskView extends StatefulWidget {
  final String projectId;
  final String? sectionId;

  const AddTaskView({
    super.key,
    required this.projectId,
    this.sectionId,
  });

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionDateController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionDateController.dispose();
    super.dispose();
  }

  _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        TaskModel(
          projectId: widget.projectId,
          sectionId: widget.sectionId,
          content: _titleController.text,
          description: _descriptionDateController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            AppBar(
              title: const Text('Add New Task'),
            ),
            TextFieldWidget(
              key: const Key('task_title_field_key'),
              controller: _titleController,
              title: 'Title',
              autoValidate: true,
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              onFieldSubmitted: (_) => _proceed(),
              validator: (value) => validator.validateField(
                value,
                field: 'Content',
              ),
            ),
            TextFieldWidget(
              key: const Key('task_description_field_key'),
              controller: _descriptionDateController,
              title: 'Description',
              autoValidate: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              minLines: 3,
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
