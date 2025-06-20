// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get codeInputTitle => 'Paste your code snippet below:';

  @override
  String get codeInputHint => 'Paste code here...';

  @override
  String get codeInputButton => 'Analyze';

  @override
  String get systemPromptLang => 'English';

  @override
  String get resultErr => 'Failed to get AI result.';

  @override
  String get resultTabSummary => 'Summary';

  @override
  String get resultTabLineByLine => 'Line-by-Line';

  @override
  String get resultTabGlossary => 'Glossary';

  @override
  String get resultTabLearningPath => 'Learning Path';

  @override
  String get resultLoading => 'Loading...';

  @override
  String get resultNoCode => 'No code analyzed yet.';

  @override
  String get navbarInputCode => 'Input Code';

  @override
  String get navbarResults => 'Result';

  @override
  String get navbarSetting => 'Setting';

  @override
  String get titleWelcome => 'Welcome to CodeMap';

  @override
  String get msgInputLimitReached =>
      'Account code input limit reached. Please try again 6 hours later.';

  @override
  String get msgContinueWithGoogle =>
      'Please continue with Google account to use this app.';

  @override
  String get btnContinueWithGoogle => 'Continue with Google';

  @override
  String get msgSignInFailed => 'Sign in failed. Please try again.';
}
