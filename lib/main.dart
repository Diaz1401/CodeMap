import 'package:codemap/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(ThemeData.light().textTheme);
    return MaterialApp(
      title: 'CodeMap',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Color(0x00aac7ff),
      //     onPrimary: Color(0xFF00315D),
      //     primaryContainer: Color(0xFF004883),
      //     onPrimaryContainer: Color(0xFFD2E4FF),
      //     secondary: Color(0xFFB6B8C8),
      //     onSecondary: Color(0xFF232537),
      //     secondaryContainer: Color(0xFF393B4E),
      //     onSecondaryContainer: Color(0xFFD3D6EB),
      //     tertiary: Color(0xFFB7C9EA),
      //     onTertiary: Color(0xFF1F314A),
      //     tertiaryContainer: Color(0xFF364862),
      //     onTertiaryContainer: Color(0xFFD5E3FF),
      //     error: Color(0xFFFFB4AB),
      //     onError: Color(0xFF690005),
      //     errorContainer: Color(0xFF93000A),
      //     onErrorContainer: Color(0xFFFFDAD6),
      //     background: Color(0xFF1A1C1E),
      //     onBackground: Color(0xFFE2E2E6),
      //     surface: Color(0xFF1A1C1E),
      //     onSurface: Color(0xFFE2E2E6),
      //     surfaceVariant: Color(0xFF43474E),
      //     onSurfaceVariant: Color(0xFFC3C7CF),
      //     outline: Color(0xFF8D9199),
      //     shadow: Color(0xFF000000),
      //     inverseSurface: Color(0xFFE2E2E6),
      //     onInverseSurface: Color(0xFF2F3033),
      //     inversePrimary: Color(0xFF0061A4),
      //     surfaceTint: Color(0xFF90CAF9),
      //   ),
      //   appBarTheme: const AppBarTheme(
      //     foregroundColor: Colors.white70,
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.blue.shade200,
      //       foregroundColor: Colors.white70,
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(12)),
      //       ),
      //       textStyle: const TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   inputDecorationTheme: InputDecorationTheme(
      //     border: OutlineInputBorder(),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
      //     ),
      //   ),
      //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     selectedItemColor: Colors.blue.shade200,
      //   ),
      // ),
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('id'), // Bahasa Indonesia
      ],
      home: const MainNavigation(),
    );
  }
}
