import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Taskly';

  @override
  String get okay => 'Okay';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get thememode => 'Theme Mode';

  @override
  String get annonymous => 'Annonymous';

  @override
  String get addNewProject => 'Add New Project';

  @override
  String get addProject => 'Add Project';

  @override
  String get updateProject => 'Update Project';

  @override
  String get addNewSection => 'Add New Section';

  @override
  String get addSection => 'Add Section';

  @override
  String get updateSection => 'Update Section';

  @override
  String get addNewTask => 'Add New Task';

  @override
  String get addTask => 'Add Task';

  @override
  String get updateTask => 'Update Task';

  @override
  String get reopen => 'Reopen';

  @override
  String get complete => 'Complete';

  @override
  String get name => 'Name';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get dueDate => 'Due Date';

  @override
  String get comments => 'Comments';

  @override
  String get updatingComment => 'Updating comment...';

  @override
  String get projectNameHint => 'What\'s the name of the project?';

  @override
  String get sectionNameHint => 'What\'s the name of the section?';

  @override
  String get titleHint => 'What\'s the title of the task?';

  @override
  String get descriptionHint => 'Describe the task...';

  @override
  String get commentsHint => 'Add a comment...';

  @override
  String get dueDateHint => 'When is the task due?';

  @override
  String get someErrorOccured => 'Some Error Occured!';

  @override
  String get networkNotAvailable => 'Network not available!';

  @override
  String get requestTimeout => 'Request timeout!';

  @override
  String get noDataFound => 'No data found!';

  @override
  String emptyField(String field) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field',
        'other': '$field',
      },
    );
    return '$_temp0 is required';
  }

  @override
  String inputLengthError(String field, int min, int max) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field must be $min-$max characters long',
        'other': '$field must be $min-$max characters long',
      },
    );
    return '$_temp0';
  }

  @override
  String inputMinLengthError(String field, int min) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field must have at least $min characters',
        'other': '$field must have at least $min characters',
      },
    );
    return '$_temp0';
  }

  @override
  String inputMaxLengthError(String field, int max) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field can contain upto $max characters',
        'other': '$field can contain upto $max characters',
      },
    );
    return '$_temp0';
  }

  @override
  String inputMaxValueError(String field, String value) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field max limit $value characters',
        'other': '$field max limit $value',
      },
    );
    return '$_temp0';
  }

  @override
  String fieldNotMatch(String field) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field',
        'other': '$field',
      },
    );
    return '$_temp0 doesn\'t match';
  }

  @override
  String notValidField(String field) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field',
        'other': '$field',
      },
    );
    return 'Enter a valid $_temp0';
  }
}
