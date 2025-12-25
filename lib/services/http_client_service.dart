import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'
    as http;
import 'token_storage_service.dart';

class HttpClientService {
  static const String
  baseUrl =
      'http://192.168.1.68:8000';
  static const Duration
  timeoutDuration = Duration(
    seconds:
        30,
  );

  static Map<
    String,
    String
  >
  get _defaultHeaders => {
    'Content-Type':
        'application/json',
    'Accept':
        'application/json',
  };

  // GET request
  static Future<
    http.Response
  >
  get(
    String
    endpoint, {
    Map<
      String,
      String
    >?
    headers,
    Map<
      String,
      String
    >?
    queryParams,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    );
    final finalUri =
        queryParams !=
            null
        ? uri.replace(
            queryParameters: queryParams,
          )
        : uri;

    final finalHeaders = {
      ..._defaultHeaders,
    };
    if (headers !=
        null) {
      finalHeaders.addAll(
        headers,
      );
    }

    try {
      final response = await http
          .get(
            finalUri,
            headers: finalHeaders,
          )
          .timeout(
            timeoutDuration,
          );

      return response;
    } on SocketException {
      throw Exception(
        'No internet connection',
      );
    } on HttpException {
      throw Exception(
        'HTTP error occurred',
      );
    } catch (
      e
    ) {
      throw Exception(
        'Request failed: $e',
      );
    }
  }

  // POST request
  static Future<
    http.Response
  >
  post(
    String
    endpoint, {
    Map<
      String,
      dynamic
    >?
    body,
    Map<
      String,
      String
    >?
    headers,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    );
    final finalHeaders = {
      ..._defaultHeaders,
    };
    if (headers !=
        null) {
      finalHeaders.addAll(
        headers,
      );
    }

    try {
      final response = await http
          .post(
            uri,
            headers: finalHeaders,
            body:
                body !=
                    null
                ? json.encode(
                    body,
                  )
                : null,
          )
          .timeout(
            timeoutDuration,
          );

      return response;
    } on SocketException {
      throw Exception(
        'No internet connection',
      );
    } on HttpException {
      throw Exception(
        'HTTP error occurred',
      );
    } catch (
      e
    ) {
      throw Exception(
        'Request failed: $e',
      );
    }
  }

  // Add authorization header for authenticated requests
  static Future<
    Map<
      String,
      String
    >
  >
  getAuthHeaders() async {
    final token =
        await TokenStorageService.getToken();
    final headers = {
      ..._defaultHeaders,
    };

    if (token !=
        null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
