import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Test if remote API is accessible.', () async {
    final Uri url = Uri.parse(
      "https://constitution-of-india-rag-app-tapoban-rays-projects.vercel.app/content",
    );
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"query": "Law"}),
    );
    // final response = await http.get(url);
    print(response.body);
    expect(response.statusCode, 200);
  });
}
