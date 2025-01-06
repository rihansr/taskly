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
  String get update => 'Update';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

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
