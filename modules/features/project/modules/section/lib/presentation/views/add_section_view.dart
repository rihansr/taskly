import 'package:core/styles/strings.dart';
import 'package:core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/section_model.dart';

class AddSectionView extends StatefulWidget {
  final String? projectID;
  final SectionModel? section;
  final bool _onEditMode;
  const AddSectionView({
    super.key,
    this.projectID,
    this.section,
  }) : _onEditMode = section != null;

  @override
  State<AddSectionView> createState() => _AddSectionViewState();
}

class _AddSectionViewState extends State<AddSectionView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late SectionModel _section;

  @override
  void initState() {
    _section = widget.section ?? const SectionModel();
    _nameController = TextEditingController(text: widget.section?.name);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        _section.copyWith(
          projectId: widget.projectID,
          name: _nameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            AppBar(
              title: Text(
                widget._onEditMode
                    ? string.of(context).updateSection
                    : string.of(context).addNewSection,
              ),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              key: const Key('section_name_field_key'),
              controller: _nameController,
              title: string.of(context).name,
              hintText: string.of(context).sectionNameHint,
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
              key: const Key('add_section_button_key'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () => _proceed(),
              child: Text(
                widget._onEditMode
                    ? string.of(context).updateSection
                    : string.of(context).addNewSection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
