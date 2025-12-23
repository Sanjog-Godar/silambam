import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();
  static const String baseUrl = 'http://localhost';

  /// Authenticate judge and return token string on success
  static Future<String> loginJudge(String email, String password) async {
    final uri = Uri.parse('$baseUrl/api/judge/login');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (resp.statusCode == 200) {
      final map = jsonDecode(resp.body) as Map<String, dynamic>;
      final token = map['token']?.toString();
      if (token != null && token.isNotEmpty) return token;
      throw Exception('No token in response');
    }

    final err = resp.body.isNotEmpty ? resp.body : 'Status ${resp.statusCode}';
    throw Exception('Login failed: $err');
  }

  /// Submit judge score
  static Future<Map<String, dynamic>> submitJudgeScore({
    required int judgeId,
    required String color,
    required double score,
    required int groupId,
    String? token,
  }) async {
    final uri = Uri.parse('$baseUrl/api/v1/judge-score');
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';

    final resp = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'judge_id': judgeId,
        'color': color,
        'score': score,
        'group_id': groupId,
      }),
    );

    final map = resp.body.isNotEmpty ? jsonDecode(resp.body) as Map<String, dynamic> : <String, dynamic>{};
    if (resp.statusCode == 201 || resp.statusCode == 200) return map;
    throw Exception('Submit failed: ${resp.statusCode} ${map['message'] ?? ''}');
  }

  /// Get tournaments (paginated)
  static Future<Map<String, dynamic>> getTournaments({int perPage = 10}) async {
    final uri = Uri.parse('$baseUrl/api/v1/tournaments?per_page=$perPage');
    final resp = await http.get(uri, headers: {'Accept': 'application/json'});
    if (resp.statusCode == 200) return jsonDecode(resp.body) as Map<String, dynamic>;
    throw Exception('Fetch tournaments failed: ${resp.statusCode}');
  }

  /// Get groups for campaign
  static Future<Map<String, dynamic>> getGroups(int campaignId) async {
    final uri = Uri.parse('$baseUrl/api/v1/groups');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'campaign_id': campaignId}),
    );
    if (resp.statusCode == 200) return jsonDecode(resp.body) as Map<String, dynamic>;
    throw Exception('Fetch groups failed: ${resp.statusCode}');
  }

  /// Get scoreboard for a group
  static Future<Map<String, dynamic>> getScoreboard(int groupId) async {
    final uri = Uri.parse('$baseUrl/api/v1/scoreboard?group_id=$groupId');
    final resp = await http.get(uri, headers: {'Accept': 'application/json'});
    if (resp.statusCode == 200) return jsonDecode(resp.body) as Map<String, dynamic>;
    throw Exception('Fetch scoreboard failed: ${resp.statusCode}');
  }
}
