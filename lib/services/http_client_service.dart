import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart'
    as http;
import 'token_storage_service.dart';

/// Custom exception class for HTTP client errors
class HttpClientException
    implements
        Exception {
  final String
  message;
  final String?
  endpoint;
  final int?
  statusCode;
  final dynamic
  originalError;

  HttpClientException({
    required this.message,
    this.endpoint,
    this.statusCode,
    this.originalError,
  });

  @override
  String
  toString() =>
      'HttpClientException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}${endpoint != null ? ' at $endpoint' : ''}';
}

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

  /// Performs a GET request to the specified endpoint
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
    try {
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

      final response = await http
          .get(
            finalUri,
            headers: finalHeaders,
          )
          .timeout(
            timeoutDuration,
          );

      return response;
    } on TimeoutException catch (
      e
    ) {
      throw HttpClientException(
        message: 'Request timeout after ${timeoutDuration.inSeconds} seconds',
        endpoint: endpoint,
        originalError: e,
      );
    } on SocketException catch (
      e
    ) {
      throw HttpClientException(
        message: 'No internet connection',
        endpoint: endpoint,
        originalError: e,
      );
    } on HttpException catch (
      e
    ) {
      throw HttpClientException(
        message: 'HTTP error occurred: ${e.message}',
        endpoint: endpoint,
        originalError: e,
      );
    } catch (
      e
    ) {
      throw HttpClientException(
        message: 'GET request failed: ${e.toString()}',
        endpoint: endpoint,
        originalError: e,
      );
    }
  }

  /// Performs a POST request to the specified endpoint
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
    try {
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
    } on TimeoutException catch (
      e
    ) {
      throw HttpClientException(
        message: 'Request timeout after ${timeoutDuration.inSeconds} seconds',
        endpoint: endpoint,
        originalError: e,
      );
    } on SocketException catch (
      e
    ) {
      throw HttpClientException(
        message: 'No internet connection',
        endpoint: endpoint,
        originalError: e,
      );
    } on HttpException catch (
      e
    ) {
      throw HttpClientException(
        message: 'HTTP error occurred: ${e.message}',
        endpoint: endpoint,
        originalError: e,
      );
    } catch (
      e
    ) {
      throw HttpClientException(
        message: 'POST request failed: ${e.toString()}',
        endpoint: endpoint,
        originalError: e,
      );
    }
  }

  /// Add authorization header for authenticated requests
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
