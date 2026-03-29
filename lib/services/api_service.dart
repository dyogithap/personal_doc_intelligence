import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class ApiService {
  // These come from your .env file
  final String projectId = dotenv.env['GOOGLE_PROJECT_ID'] ?? '';
  final String location = dotenv.env['LOCATION'] ?? 'us';
  final String processorId = dotenv.env['PROCESSOR_ID'] ?? '';

  Future<Map<String, dynamic>> processDocument(String base64Image) async {
    final url = 'https://$location-documentai.googleapis.com/v1/projects/$projectId/locations/$location/processors/$processorId:process';

    // This is the "Request" to Google
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        // We will add the OAuth Token step next!
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN', 
      },
      body: jsonEncode({
        'rawDocument': {
          'content': base64Image,
          'mimeType': 'image/jpeg',
        }
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to process document: ${response.body}');
    }
  }
}