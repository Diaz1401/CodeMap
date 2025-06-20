import 'package:flutter/material.dart';
import 'package:codemap/l10n/app_localizations.dart';
import 'package:codemap/services/userdata_service.dart';
import 'package:codemap/utils/util.dart';

class CodeInputPage extends StatefulWidget {
  final void Function(String, bool) onAnalyze;
  final void Function(String) onCodeChanged;
  final String code;

  const CodeInputPage({
    super.key,
    required this.onAnalyze,
    required this.onCodeChanged,
    required this.code,
  });

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.code);
    _controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(covariant CodeInputPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code && _controller.text != widget.code) {
      _controller.text = widget.code;
    }
  }

  void _handleTextChanged() {
    widget.onCodeChanged(_controller.text);
  }

  Future<bool> inputNotValid() async {
    final code = _controller.text;
    if (code.isEmpty) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgCodeInputEmpty,
      );
      widget.onAnalyze(_controller.text, false);
      return true;
    }
    if (code.length < 10) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgCodeInputTooShort,
      );
      widget.onAnalyze(_controller.text, false);
      return true;
    }
    final canAnalyze = await UserdataService().canAnalyze();
    if (!canAnalyze) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgInputLimitReached,
      );
      widget.onAnalyze(_controller.text, false);
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
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
                  onPressed: () async {
                    if (await inputNotValid()) return;
                    await UserdataService().incrementAnalyzeCount();
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