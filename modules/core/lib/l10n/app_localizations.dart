import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Taskly'**
  String get appName;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @thememode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get thememode;

  /// No description provided for @annonymous.
  ///
  /// In en, this message translates to:
  /// **'Annonymous'**
  String get annonymous;

  /// No description provided for @addNewProject.
  ///
  /// In en, this message translates to:
  /// **'Add New Project'**
  String get addNewProject;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @updateProject.
  ///
  /// In en, this message translates to:
  /// **'Update Project'**
  String get updateProject;

  /// No description provided for @addNewSection.
  ///
  /// In en, this message translates to:
  /// **'Add New Section'**
  String get addNewSection;

  /// No description provided for @addSection.
  ///
  /// In en, this message translates to:
  /// **'Add Section'**
  String get addSection;

  /// No description provided for @updateSection.
  ///
  /// In en, this message translates to:
  /// **'Update Section'**
  String get updateSection;

  /// No description provided for @addNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTask;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @updateTask.
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get updateTask;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get reopen;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @updatingComment.
  ///
  /// In en, this message translates to:
  /// **'Updating comment...'**
  String get updatingComment;

  /// No description provided for @projectNameHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s the name of the project?'**
  String get projectNameHint;

  /// No description provided for @sectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s the name of the section?'**
  String get sectionNameHint;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s the title of the task?'**
  String get titleHint;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the task...'**
  String get descriptionHint;

  /// No description provided for @commentsHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get commentsHint;

  /// No description provided for @dueDateHint.
  ///
  /// In en, this message translates to:
  /// **'When is the task due?'**
  String get dueDateHint;

  /// No description provided for @someErrorOccured.
  ///
  /// In en, this message translates to:
  /// **'Some Error Occured!'**
  String get someErrorOccured;

  /// No description provided for @networkNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Network not available!'**
  String get networkNotAvailable;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout!'**
  String get requestTimeout;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found!'**
  String get noDataFound;

  /// No description provided for @emptyField.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field} other {{field}}} is required'**
  String emptyField(String field);

  /// No description provided for @inputLengthError.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field must be {min}-{max} characters long} other {{field} must be {min}-{max} characters long}}'**
  String inputLengthError(String field, int min, int max);

  /// No description provided for @inputMinLengthError.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field must have at least {min} characters} other {{field} must have at least {min} characters}}'**
  String inputMinLengthError(String field, int min);

  /// No description provided for @inputMaxLengthError.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field can contain upto {max} characters} other {{field} can contain upto {max} characters}}'**
  String inputMaxLengthError(String field, int max);

  /// No description provided for @inputMaxValueError.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field max limit {value} characters} other {{field} max limit {value}}}'**
  String inputMaxValueError(String field, String value);

  /// No description provided for @fieldNotMatch.
  ///
  /// In en, this message translates to:
  /// **'{field, select, null{Field} other {{field}}} doesn\'t match'**
  String fieldNotMatch(String field);

  /// No description provided for @notValidField.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid {field, select, null{Field} other {{field}}}'**
  String notValidField(String field);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
