import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String code;
  final bool analyzed;
  const ResultsPage({super.key, required this.code, required this.analyzed});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.teal,
            tabs: [
              Tab(text: 'Summary', icon: Icon(Icons.info_outline)),
              Tab(text: 'Line-by-Line', icon: Icon(Icons.view_list)),
              Tab(text: 'Glossary', icon: Icon(Icons.book)),
              Tab(text: 'Learning Path', icon: Icon(Icons.school)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Summary Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: analyzed && code.trim().isNotEmpty
                          ? Text(
                              'Summary: You entered the following code:\n\n$code',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              'No code analyzed yet.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                    ),
                  ),
                ),
                // Line-by-Line Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: analyzed && code.trim().isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: code
                                  .split('\n')
                                  .asMap()
                                  .entries
                                  .map((entry) => Text(
                                        'Line ${entry.key + 1}: ${entry.value}',
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ))
                                  .toList(),
                            )
                          : Text(
                              'No code analyzed yet.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                    ),
                  ),
                ),
                // Glossary Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: analyzed && code.trim().isNotEmpty
                          ? Text(
                              'Glossary: (Demo) No glossary generated yet for:\n\n$code',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              'No code analyzed yet.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                    ),
                  ),
                ),
                // Learning Path Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: analyzed && code.trim().isNotEmpty
                          ? Text(
                              'Learning Path: (Demo) No learning path generated yet for:\n\n$code',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : Text(
                              'No code analyzed yet.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

