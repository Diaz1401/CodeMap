import 'package:flutter/material.dart';
import 'package:codemap/l10n/app_localizations.dart';
import 'package:codemap/services/userdata_service.dart';
import 'package:codemap/utils/util.dart';

class CodeInputPage extends StatefulWidget {
  final void Function(String, bool, String) onAnalyze;
  final void Function(String, String) onInputChanged;
  final String code;
  final String model;

  const CodeInputPage({
    super.key,
    required this.onAnalyze,
    required this.onInputChanged,
    required this.code,
    required this.model,
  });

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  late TextEditingController _controller;
  late String _selectedModel;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.code);
    _controller.addListener(_handleTextChanged);
    _selectedModel = widget.model;
  }

  DropdownButton<String> _buildDropdownButton() {
    return DropdownButton<String>(
      value: _selectedModel,
      items: const [
        DropdownMenuItem(
          value: 'gemini',
          child: Text('Google Gemini'),
        ),
        DropdownMenuItem(
          value: 'granite',
          child: Text('IBM Granite'),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedModel = value;
            widget.onInputChanged(_controller.text, _selectedModel);
          });
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant CodeInputPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code && _controller.text != widget.code) {
      _controller.text = widget.code;
    }
  }

  void _handleTextChanged() {
    widget.onInputChanged(_controller.text, _selectedModel);
  }

  Future<bool> _inputNotValid() async {
    final code = _controller.text;
    if (code.isEmpty) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgCodeInputEmpty,
      );
      widget.onAnalyze(_controller.text, false, _selectedModel);
      return true;
    }
    if (code.length < 10) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgCodeInputTooShort,
      );
      widget.onAnalyze(_controller.text, false, _selectedModel);
      return true;
    }
    final canAnalyze = await UserdataService().canAnalyze();
    if (!canAnalyze) {
      utilShowDialog(
        context,
        AppLocalizations.of(context)!.msgInputLimitReached,
      );
      widget.onAnalyze(_controller.text, false, _selectedModel);
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
              // Model dropdown
              Row(
                children: [
                  Text(
                    "Model:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 12),
                  _buildDropdownButton(),
                ],
              ),
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
                    if (await _inputNotValid()) return;
                    await UserdataService().incrementAnalyzeCount();
                    widget.onAnalyze(_controller.text, true, _selectedModel); // pass model
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
