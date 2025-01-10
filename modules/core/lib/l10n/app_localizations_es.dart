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
  String get remove => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get edit => 'Editar';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get thememode => 'Modo de tema';

  @override
  String get annonymous => 'Anónimo';

  @override
  String get addNewProject => 'Agregar nuevo proyecto';

  @override
  String get addProject => 'Agregar proyecto';

  @override
  String get updateProject => 'Actualizar proyecto';

  @override
  String get addNewSection => 'Agregar nueva sección';

  @override
  String get addSection => 'Agregar sección';

  @override
  String get updateSection => 'Actualizar sección';

  @override
  String get addNewTask => 'Agregar nueva tarea';

  @override
  String get addTask => 'Agregar tarea';

  @override
  String get updateTask => 'Actualizar tarea';

  @override
  String get reopen => 'Reabrir';

  @override
  String get complete => 'Completar';

  @override
  String get name => 'Nombre';

  @override
  String get title => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get dueDate => 'Fecha de vencimiento';

  @override
  String get comments => 'Comentarios';

  @override
  String get updatingComment => 'Actualizando comentario...';

  @override
  String get projectNameHint => '¿Cuál es el nombre del proyecto?';

  @override
  String get sectionNameHint => '¿Cuál es el nombre de la sección?';

  @override
  String get titleHint => '¿Cuál es el título de la tarea?';

  @override
  String get descriptionHint => 'Describe la tarea...';

  @override
  String get commentsHint => 'Añadir un comentario...';

  @override
  String get dueDateHint => '¿Cuándo vence la tarea?';

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
