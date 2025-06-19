import 'dart:convert';
import 'package:codemap/util/util.dart';
import 'package:http/http.dart' as http;

class AiApiService {
  // Replace with your actual Gemini API key or load from env
  final String apiKey = const String.fromEnvironment("GEMINI_API_KEY");
  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  final systemPrompt = '''
You are CodeMap, an intelligent AI designed to help programmers understand unfamiliar code across any programming language. Your job is to analyze a given code snippet and return a structured explanation divided into four sections:

1. **Summary**: Briefly describe what the code does overall. Focus on its purpose, main structure, and technologies/libraries used.

2. **Line-by-Line Explanation**: Go through the code line by line or block by block and explain what each part does. Include line numbers in the format `Line X:` followed by the explanation. Highlight important logic, variables, or behavior.

3. **Glossary**: Identify and define important keywords, functions, classes, methods, APIs, or libraries used in the code. Format as a bulleted list with the term followed by a clear, beginner-friendly explanation.

4. **Learning Path**: Recommend a progressive path of concepts or topics the user should study to understand this code. Suggest tutorials, documentation topics, or areas to master. Format this as a numbered list from beginner to advanced. Remember that this Learning Path should be tailored to the specific code snippet provided.

Your response must be clear, concise, and formatted in markdown with section headers. Wrap any code blocks using triple backticks (```).

Use the following **strict output format** with hardcoded separators between each section for backend processing:

SEPARATOR00  
## Summary  
[Your summary here]
SEPARATOR01  
## Line-by-Line Explanation  
Line 1: ...  
Line 2: ...  
...
SEPARATOR02  
## Glossary  
- term1: definition  
- term2: definition  
...
SEPARATOR03  
## Learning Path  
1. Concept 1  
2. Concept 2  
...
SEPARATOR04  

Do not include any introduction, closing statements, or content outside of this format. Only output what is inside this structure.
''';

  Future<String?> createPrediction({required String prompt}) async {
    final url = '$baseUrl?key=$apiKey';
    final fullPrompt = "$systemPrompt\n\n$prompt";
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": fullPrompt},
          ],
        },
      ],
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Gemini output: candidates[0].content.parts[0].text
      try {
        final candidates = data['candidates'];
        if (candidates is List && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          if (content != null &&
              content['parts'] is List &&
              content['parts'].isNotEmpty &&
              content['parts'][0]['text'] is String) {
            return content['parts'][0]['text'] as String;
          }
        }
        Util.printDebug("API", "Unexpected Gemini output: $data");
        return null;
      } catch (e) {
        Util.printDebug("API", "Error parsing Gemini response: $e");
        return null;
      }
    } else {
      Util.printDebug(
        "API",
        "Error: ${response.statusCode} - ${response.body}",
      );
      return null;
    }
  }
}
