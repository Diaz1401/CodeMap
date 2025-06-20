import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @codeInputTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste your code snippet below:'**
  String get codeInputTitle;

  /// No description provided for @codeInputHint.
  ///
  /// In en, this message translates to:
  /// **'Paste code here...'**
  String get codeInputHint;

  /// No description provided for @codeInputButton.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get codeInputButton;

  /// No description provided for @systemPromptLang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get systemPromptLang;

  /// No description provided for @resultErr.
  ///
  /// In en, this message translates to:
  /// **'Failed to get AI result.'**
  String get resultErr;

  /// No description provided for @resultTabSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get resultTabSummary;

  /// No description provided for @resultTabLineByLine.
  ///
  /// In en, this message translates to:
  /// **'Line-by-Line'**
  String get resultTabLineByLine;

  /// No description provided for @resultTabGlossary.
  ///
  /// In en, this message translates to:
  /// **'Glossary'**
  String get resultTabGlossary;

  /// No description provided for @resultTabLearningPath.
  ///
  /// In en, this message translates to:
  /// **'Learning Path'**
  String get resultTabLearningPath;

  /// No description provided for @resultLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get resultLoading;

  /// No description provided for @resultNoCode.
  ///
  /// In en, this message translates to:
  /// **'No code analyzed yet.'**
  String get resultNoCode;

  /// No description provided for @navbarInputCode.
  ///
  /// In en, this message translates to:
  /// **'Input Code'**
  String get navbarInputCode;

  /// No description provided for @navbarResults.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get navbarResults;

  /// No description provided for @navbarSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navbarSetting;

  /// No description provided for @titleWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CodeMap'**
  String get titleWelcome;

  /// No description provided for @msgInputLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Account code input limit reached. Please try again 6 hours later.'**
  String get msgInputLimitReached;

  /// No description provided for @msgContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Please continue with Google account to use this app.'**
  String get msgContinueWithGoogle;

  /// No description provided for @btnContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get btnContinueWithGoogle;

  /// No description provided for @msgSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed. Please try again.'**
  String get msgSignInFailed;

  /// No description provided for @txtUserProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get txtUserProfile;

  /// No description provided for @msgSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view your profile.'**
  String get msgSignInRequired;

  /// No description provided for @txtReqLeft.
  ///
  /// In en, this message translates to:
  /// **'Requests Left'**
  String get txtReqLeft;

  /// No description provided for @btnSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get btnSignOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
