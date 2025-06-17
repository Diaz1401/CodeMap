import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class ResultsPage extends StatelessWidget {
  final String code;
  final bool analyzed;
  const ResultsPage({super.key, required this.code, required this.analyzed});
  final markdownStringTest1 = '''
## ChatGPT Response

Welcome to ChatGPT! Below is an example of a response with Markdown and LaTeX code:

### Markdown Example

You can use Markdown to format text easily. Here are some examples:

- **Bold Text**: **This text is bold**
- *Italic Text*: *This text is italicized*
- [Link](https://www.example.com): [This is a link](https://www.example.com)
- Lists:
  1. Item 1
  2. Item 2
  3. Item 3
- Code Block:
  ```dart
  void main() {
    print('Hello, World!');
  }
  ```
- Inline Code: `print('Hello, World!')`
- Blockquote:
  > This is a blockquote. It can be used to highlight important information.
''';
  final markdownStringTest2 = '''
## Summary

This Flutter code defines a `ResultsPage` widget, a stateless UI component that displays the results of analyzing a block of source code. It presents the results in four tabs—**Summary**, **Line-by-Line**, **Glossary**, and **Learning Path**—each rendering Markdown-like formatted content dynamically based on whether the `analyzed` flag is true and `code` is provided. It uses widgets like `TabBar`, `TabBarView`, and `Card` for structured display and includes a custom helper function `parseMarkdownBlocks()` to render both plain text and code blocks.

## Line-by-Line Explanation

Line 1: Imports the Flutter material design package for UI components.
Line 3: Defines a `ResultsPage` class extending `StatelessWidget`.
Line 4–5: Declares two required final fields: `code` (a string of code to analyze) and `analyzed` (a boolean flag).
Line 6: Constructor accepting named parameters for `code` and `analyzed`.

Line 9: Begins a helper method `parseMarkdownBlocks` that takes a string and returns a list of Flutter `Widget`s.
Line 10: Splits the input text into lines.
Line 11: Initializes an empty list of widgets.
Line 12–14: Initializes variables for tracking code blocks and buffers for code/text lines.

Line 16–22: Defines `flushText()`, which adds text as a `Text` widget with bottom padding and resets the buffer.
Line 24–35: Defines `flushCode()`, which adds code as a stylized `Container` widget using monospaced font.

Line 37–47: Iterates over each line. If the line is '\`\`\`', it toggles between code and text mode and flushes the current buffer. Otherwise, it appends the line to the active buffer.
Line 48–52: Flushes remaining buffers after loop ends.
Line 53: Returns the list of parsed widgets.

Line 56: Overrides the `build` method of the stateless widget.
Line 57: Wraps the UI in a `DefaultTabController` with 4 tabs.
Line 58–65: Defines the `TabBar` with four labeled tabs and icons.
Line 66–144: Creates the `TabBarView` that shows different content for each tab.

Line 69–88: Tab 1 (Summary): If `analyzed` is true and `code` is not empty, it renders a `Card` with parsed summary content. Otherwise, it shows a fallback message.
Line 90–109: Tab 2 (Line-by-Line): Similar to summary, but each line of code is prefixed with "Line X:" before rendering.
Line 111–130: Tab 3 (Glossary): Placeholder that echoes the code block inside a glossary structure.
Line 132–144: Tab 4 (Learning Path): Placeholder for learning path structure with the code block.

## Glossary

* **Flutter**: A UI framework from Google for building natively compiled apps for mobile, web, and desktop from a single codebase.
* **StatelessWidget**: A Flutter widget that does not hold mutable state and is rebuilt only when its parent widget changes.
* **DefaultTabController**: A widget that handles tab selection state for `TabBar` and `TabBarView`.
* **TabBar**: A horizontal row of tabs used to switch between views.
* **TabBarView**: Displays different content for each tab selected in a `TabBar`.
* **Card**: A Material Design card container with elevation and padding.
* **Text**: A widget for displaying text.
* **Container**: A box model widget in Flutter used for layout and styling.
* **Padding**: Adds spacing around a widget.
* **List<Widget>**: A list of Flutter widgets used to render multiple UI elements.
* **monospace**: A font where every character has the same width, often used for code.

## Learning Path

1. Learn Dart basics (variables, functions, classes)
2. Study Flutter widget tree and StatelessWidget vs StatefulWidget
3. Practice layout widgets like `Column`, `Padding`, `Container`
4. Understand tab navigation using `TabBar` and `TabBarView`
5. Learn how to manage UI state and interactivity in Flutter
6. Study how to build custom parsing functions in Dart
7. Explore Markdown parsing or integrate libraries like `flutter_markdown`
8. Build a complete Flutter app with dynamic content rendering based on user input
''';

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
                          ? Markdown(data: markdownStringTest2, selectable: true)
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
                                  .map(
                                    (entry) => Text(
                                      'Line ${entry.key + 1}: ${entry.value}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  )
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
