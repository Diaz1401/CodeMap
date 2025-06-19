import 'package:flutter/material.dart';
import 'pages/code_input_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CodeMap')),
      body: _selectedIndex == 0
          ? CodeInputPage(onAnalyze: _onAnalyze, code: _code)
          : _selectedIndex == 1
          ? ResultsPage(code: _code, analyzed: _analyzed)
          : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Code Input'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}