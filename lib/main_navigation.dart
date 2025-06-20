import 'package:codemap/pages/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'pages/codeinput_page.dart';
import 'pages/results_page.dart';
import 'pages/settings_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  String _code = '';
  bool _analyzed = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAnalyze(String code, bool analyzed) {
    setState(() {
      _code = code;
      _analyzed = analyzed;
      _selectedIndex = 1; // Switch to Results tab
    });
  }

  void _onCodeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text('CodeMap', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),),
                const Spacer(),
                FutureBuilder<User?>(
                  future: Future.value(FirebaseAuth.instance.currentUser),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    return IconButton(
                      icon: user?.photoURL != null
                          ? CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                        radius: 24,
                      )
                          : const Icon(Icons.account_circle, size: 42),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const UserProfilePage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
        ),
      ),
      body: _selectedIndex == 0
          ? CodeInputPage(
              onCodeChanged: _onCodeChanged,
              onAnalyze: _onAnalyze,
              code: _code,
            )
          : _selectedIndex == 1
          ? ResultsPage(code: _code, analyzed: _analyzed)
          : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.code),
            label: AppLocalizations.of(context)!.navbarInputCode,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description),
            label: AppLocalizations.of(context)!.navbarResults,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: AppLocalizations.of(context)!.navbarSetting,
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
