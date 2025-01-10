import 'package:core/styles/strings.dart';
import 'package:core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/project_model.dart';

class AddProjectView extends StatefulWidget {
  final ProjectModel? project;
  final bool _onEditMode;
  const AddProjectView({
    super.key,
    this.project,
  }) : _onEditMode = project != null;

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late ProjectModel _project;

  @override
  void initState() {
    _project = widget.project ?? const ProjectModel();
    _nameController = TextEditingController(text: widget.project?.name);
    super.initState();
  }

  _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        _project.copyWith(
          name: _nameController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            AppBar(
              title: Text(
                widget._onEditMode
                    ? string.of(context).updateProject
                    : string.of(context).addNewProject,
              ),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              key: const Key('project_name_field_key'),
              controller: _nameController,
              title: string.of(context).name,
              hintText: string.of(context).projectNameHint,
              autoValidate: true,
              textCapitalization: TextCapitalization.words,
              onFieldSubmitted: (_) => _proceed(),
              validator: (value) => validator.validateField(
                value,
                field: string.of(context).name,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('add_project_button_key'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () => _proceed(),
              child: Text(
                widget._onEditMode
                    ? string.of(context).updateProject
                    : string.of(context).addProject,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
