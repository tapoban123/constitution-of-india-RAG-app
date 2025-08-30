import 'dart:convert';
import 'dart:developer';

import 'package:constitution_app/models/ai_response_model.dart';
import 'package:http/http.dart' as http;

class AiGenerationService {
  Future<AiResponseModel?> getAiResponse({required String query}) async {
    try {
      final Uri url = Uri.parse(
        "https://constitution-of-india-rag-app-tapoban-rays-projects.vercel.app/content/",
      );
      final response = await http.post(url, body: jsonEncode({"query": query}));

      if (response.statusCode == 200) {
        log(response.toString());
        return AiResponseModel.fromJson(jsonDecode(response.body));
      }
      log(response.body);
      log(response.statusCode.toString());
      log(response.request.toString());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
