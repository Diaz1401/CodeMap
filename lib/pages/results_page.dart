import 'package:codemap/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:codemap/services/api_service.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class ResultsPage extends StatefulWidget {
  final String code;
  final String model;
  final bool analyzed;
  const ResultsPage({super.key, required this.code, required this.analyzed, required this.model});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  // Static variables to persist data across rebuilds
  static String _persistedMarkdownBuffer = '';
  static String _persistedCode = '';
  static bool _persistedHasAnalyzed = false;

  String _markdownBuffer = '';
  bool _loading = false;
  String? _error;
  bool _hasAnalyzed = false;
  bool _didFetch = false;

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
    // Save our state before disposing
    _persistedMarkdownBuffer = _markdownBuffer;
    _persistedHasAnalyzed = _hasAnalyzed;
    _persistedCode = widget.code;
    super.dispose();
  }

  Future<void> _fetchAiResult() async {
    setState(() {
      _markdownBuffer = '';
      _loading = true;
      _error = null;
    });

    final apiService = ApiService();
    final result = await apiService.sendPrompt(
      prompt: widget.code,
      model: widget.model,
      context: context,
    );

    if (result == null) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context)!.resultErr;
      });
      return;
    }

    setState(() {
      _markdownBuffer = result;
      _loading = false;
      _hasAnalyzed = true;
      // Update persisted values
      _persistedMarkdownBuffer = result;
      _persistedHasAnalyzed = true;
      _persistedCode = widget.code;
    });
  }

  @override
  void didUpdateWidget(covariant ResultsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.analyzed &&
        widget.code.trim().isNotEmpty &&
        ((oldWidget.code != widget.code && widget.code != _persistedCode) ||
            (!oldWidget.analyzed &&
                widget.analyzed &&
                !_persistedHasAnalyzed))) {
      _fetchAiResult();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetch) {
      // Restore state from persisted values if available and matching current code
      if (_persistedHasAnalyzed &&
          _persistedCode == widget.code &&
          _persistedMarkdownBuffer.isNotEmpty) {
        _markdownBuffer = _persistedMarkdownBuffer;
        _hasAnalyzed = true;
      }
      // Otherwise, only fetch on initial load if the analyzed flag is true and we haven't analyzed this code
      else if (widget.analyzed &&
          widget.code.trim().isNotEmpty &&
          !_hasAnalyzed) {
        _fetchAiResult();
      }
      _didFetch = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.resultTabSummary,
                icon: const Icon(Icons.info_outline),
              ),
              Tab(
                text: AppLocalizations.of(context)!.resultTabLineByLine,
                icon: const Icon(Icons.view_list),
              ),
              Tab(
                text: AppLocalizations.of(context)!.resultTabGlossary,
                icon: const Icon(Icons.book),
              ),
              Tab(
                text: AppLocalizations.of(context)!.resultTabLearningPath,
                icon: const Icon(Icons.school),
              ),
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
                                ? Text(
                                    AppLocalizations.of(context)!.resultLoading,
                                  )
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 0),
                                    selectable: true,
                                  )
                          : Text(
                              AppLocalizations.of(context)!.resultNoCode,
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
                                ? Text(
                                    AppLocalizations.of(context)!.resultLoading,
                                  )
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 1),
                                    selectable: true,
                                  )
                          : Text(
                              AppLocalizations.of(context)!.resultNoCode,
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
                                ? Text(
                                    AppLocalizations.of(context)!.resultLoading,
                                  )
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 2),
                                    selectable: true,
                                  )
                          : Text(
                              AppLocalizations.of(context)!.resultNoCode,
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
                                ? Text(
                                    AppLocalizations.of(context)!.resultLoading,
                                  )
                                : Markdown(
                                    data: _extractSection(_markdownBuffer, 3),
                                    selectable: true,
                                    onTapLink: (text, href, title) async {
                                      if (href != null) {
                                        await launchUrl(Uri.parse(href));
                                      }
                                    },
                                  )
                          : Text(
                              AppLocalizations.of(context)!.resultNoCode,
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
