import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Taskly';

  @override
  String get okay => 'De acuerdo';

  @override
  String get retry => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get thememode => 'Modo de tema';

  @override
  String get annonymous => 'Anónimo';

  @override
  String get someErrorOccured => '¡Se produjo algún error!';

  @override
  String get networkNotAvailable => '¡Red no disponible!';

  @override
  String get requestTimeout => '¡Tiempo de espera de la solicitud!';

  @override
  String get noDataFound => '¡No se encontraron datos!';

  @override
  String emptyField(String field) {
    String _temp0 = intl.Intl.selectLogic(
      field,
      {
        'null': 'Field',
        'other': '$field',
      },
    );
    return '$_temp0 es requerido';
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
    return '$_temp0 no coincide';
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
    return '$_temp0 no es válido';
  }
}
