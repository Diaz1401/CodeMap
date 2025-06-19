import 'package:flutter/material.dart';
import 'package:codemap/l10n/app_localizations.dart';

class CodeInputPage extends StatefulWidget {
  final void Function(String, bool) onAnalyze;
  final String code;
  const CodeInputPage({super.key, required this.onAnalyze, required this.code});

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.code);
  }

  @override
  void didUpdateWidget(covariant CodeInputPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code) {
      _controller.text = widget.code;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.codeInputTitle),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controller,
                        maxLines: 15,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: AppLocalizations.of(context)!.codeInputHint,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 16,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAnalyze(_controller.text, true);
                  },
                  child: Text(AppLocalizations.of(context)!.codeInputButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}