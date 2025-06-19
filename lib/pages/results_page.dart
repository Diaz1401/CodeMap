import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:codemap/service/api_service.dart';
import 'dart:async';

class ResultsPage extends StatefulWidget {
  final String code;
  final bool analyzed;
  const ResultsPage({super.key, required this.code, required this.analyzed});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String _markdownBuffer = '';
  bool _loading = false;
  String? _error;

  String _extractSection(String buffer, int section) {
    // section: 0 = Summary, 1 = Line-by-Line, 2 = Glossary, 3 = Learning Path
    final sep00 = 'SEPARATOR00';
    final sep01 = 'SEPARATOR01';
    final sep02 = 'SEPARATOR02';
    final sep03 = 'SEPARATOR03';
    final sep04 = 'SEPARATOR04';

    List<String> seps = [sep00, sep01, sep02, sep03, sep04];
    int start = buffer.indexOf(seps[section]);
    int end = buffer.indexOf(seps[section + 1]);
    if (start != -1 && end != -1 && end > start) {
      return buffer.substring(start + seps[section].length, end).trim();
    }
    // fallback: if not found, try to return everything after start
    if (start != -1) {
      return buffer.substring(start + seps[section].length).trim();
    }
    return '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchAiResult() async {
    setState(() {
      _markdownBuffer = '';
      _loading = true;
      _error = null;
    });

    final aiService = AiApiService();
    final result = await aiService.createPrediction(prompt: widget.code);

    if (result == null) {
      setState(() {
        _loading = false;
        _error = 'Failed to get AI result.';
      });
      return;
    }

    setState(() {
      _markdownBuffer = result;
      _loading = false;
    });
  }

  @override
  void didUpdateWidget(covariant ResultsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.analyzed &&
        widget.code.trim().isNotEmpty &&
        (oldWidget.code != widget.code || !oldWidget.analyzed)) {
      _fetchAiResult();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.analyzed && widget.code.trim().isNotEmpty) {
      _fetchAiResult();
    }
  }

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
                // Summary Section (AI result)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: widget.analyzed && widget.code.trim().isNotEmpty
                          ? _error != null
                                ? Text(
                                    _error!,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : _loading
                                ? const Text('Loading...')
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 0),
                                    selectable: true,
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
                      child: widget.analyzed && widget.code.trim().isNotEmpty
                          ? _error != null
                                ? Text(
                                    _error!,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : _loading
                                ? const Text('Loading...')
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 1),
                                    selectable: true,
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
                      child: widget.analyzed && widget.code.trim().isNotEmpty
                          ? _error != null
                                ? Text(
                                    _error!,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : _loading
                                ? const Text('Loading...')
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 2),
                                    selectable: true,
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
                      child: widget.analyzed && widget.code.trim().isNotEmpty
                          ? _error != null
                                ? Text(
                                    _error!,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : _loading
                                ? const Text('Loading...')
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 3),
                                    selectable: true,
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
