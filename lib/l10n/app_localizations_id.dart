// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get codeInputTitle => 'Tempelkan potongan kode dibawah:';

  @override
  String get codeInputHint => 'Tempelkan kode disini...';

  @override
  String get codeInputButton => 'Analisa';

  @override
  String get systemPromptLang => 'Bahasa Indonesia';

  @override
  String get resultErr => 'Gagal mendapatkan hasil AI.';

  @override
  String get resultTabSummary => 'Ringkasan';

  @override
  String get resultTabLineByLine => 'Baris demi Baris';

  @override
  String get resultTabGlossary => 'Glosarium';

  @override
  String get resultTabLearningPath => 'Jalur Pembelajaran';

  @override
  String get resultLoading => 'Memuat...';

  @override
  String get resultNoCode => 'Belum ada kode yang dianalisis.';

  @override
  String get navbarInputCode => 'Masukan Kode';

  @override
  String get navbarResults => 'Hasil';

  @override
  String get navbarSetting => 'Pengaturan';
}
