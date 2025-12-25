import 'dart:convert';
import 'package:http/http.dart'
    as http;
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/api_error.dart';
import 'http_client_service.dart';
import 'token_storage_service.dart';

class AuthApiService {
  static const String
  loginEndpoint =
      '/api/judge/login';

  // Judge Login API call
  static Future<
    LoginResponse
  >
  judgeLogin({
    required String
    email,
    required String
    password,
  }) async {
    try {
      final loginRequest = LoginRequest(
        email: email,
        password: password,
      );

      final response = await HttpClientService.post(
        loginEndpoint,
        body: loginRequest.toJson(),
      );

      return _handleLoginResponse(
        response,
        email,
      );
    } catch (
      e
    ) {
      throw ApiError(
        message: e.toString(),
      );
    }
  }

  // Handle login response
  static Future<
    LoginResponse
  >
  _handleLoginResponse(
    http.Response
    response,
    String
    email,
  ) async {
    final responseBody = json.decode(
      response.body,
    );

    if (response.statusCode ==
        200) {
      final loginResponse = LoginResponse.fromJson(
        responseBody,
      );

      // Store token and email
      await TokenStorageService.saveToken(
        loginResponse.token,
      );
      await TokenStorageService.saveEmail(
        email,
      );

      return loginResponse;
    } else {
      // Handle different error status codes
      String
      errorMessage;

      switch (response.statusCode) {
        case 400:
          errorMessage =
              responseBody['message'] ??
              'Invalid request data';
          break;
        case 401:
          errorMessage =
              responseBody['message'] ??
              'Invalid email or password';
          break;
        case 403:
          errorMessage =
              responseBody['message'] ??
              'Access forbidden';
          break;
        case 404:
          errorMessage =
              responseBody['message'] ??
              'Login endpoint not found';
          break;
        case 422:
          errorMessage =
              responseBody['message'] ??
              'Validation failed';
          break;
        case 500:
          errorMessage = 'Server error. Please try again later';
          break;
        default:
          errorMessage =
              responseBody['message'] ??
              'Login failed';
      }

      throw ApiError(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }

  // Logout functionality
  static Future<
    bool
  >
  logout() async {
    try {
      // Clear stored data
      await TokenStorageService.clearAll();
      return true;
    } catch (
      e
    ) {
      return false;
    }
  }

  // Check authentication status
  static Future<
    bool
  >
  isAuthenticated() async {
    return await TokenStorageService.isLoggedIn();
  }

  // Get current user email
  static Future<
    String?
  >
  getCurrentUserEmail() async {
    return await TokenStorageService.getEmail();
  }
}
