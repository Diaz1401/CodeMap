import 'dart:convert';
import 'package:http/http.dart' as http;

class AiApiService {
  final String apiToken;
  final baseUrl =
      'https://api.replicate.com/v1/models/ibm-granite/granite-3.3-8b-instruct/predictions';
  final systemPrompt = '''
You are CodeMap, an intelligent AI designed to help programmers understand unfamiliar code across any programming language. Your job is to analyze a given code snippet and return a structured explanation divided into four sections:

1. **Summary**: Briefly describe what the code does overall. Focus on its purpose, main structure, and technologies/libraries used.

2. **Line-by-Line Explanation**: Go through the code line by line or block by block and explain what each part does. Include line numbers in the format `Line X:` followed by the explanation. Highlight important logic, variables, or behavior.

3. **Glossary**: Identify and define important keywords, functions, classes, methods, APIs, or libraries used in the code. Format as a bulleted list with the term followed by a clear, beginner-friendly explanation.

4. **Learning Path**: Recommend a progressive path of concepts or topics the user should study to understand this code. Suggest tutorials, documentation topics, or areas to master. Format this as a numbered list from beginner to advanced.

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

  AiApiService({required this.apiToken});

  Future<String?> createPrediction({required String prompt}) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'stream': true,
        'input': {'prompt': prompt, 'system_prompt': systemPrompt},
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['urls']?['stream'] as String?;
    } else {
      // Handle error
      return null;
    }
  }

  Stream<String> streamPrediction(String streamUrl) async* {
    final request = http.Request('GET', Uri.parse(streamUrl));
    request.headers.addAll({
      'Accept': 'text/event-stream',
      'Cache-Control': 'no-store',
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      await for (final line in response.stream.transform(utf8.decoder)) {
        yield line;
      }
    } else {
      yield 'Error: ${response.statusCode}';
    }
  }
}
