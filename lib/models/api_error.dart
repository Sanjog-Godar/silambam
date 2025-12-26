/// Enum for HTTP error codes and their meanings
enum ErrorCode {
  badRequest(
    400,
    'Bad Request',
  ),
  unauthorized(
    401,
    'Unauthorized',
  ),
  forbidden(
    403,
    'Forbidden',
  ),
  notFound(
    404,
    'Not Found',
  ),
  validationFailed(
    422,
    'Validation Failed',
  ),
  serverError(
    500,
    'Server Error',
  ),
  unknown(
    0,
    'Unknown Error',
  );

  final int
  code;
  final String
  description;

  const ErrorCode(
    this.code,
    this.description,
  );

  /// Factory constructor to create ErrorCode from status code
  factory ErrorCode.fromStatusCode(
    int
    statusCode,
  ) {
    return ErrorCode.values.firstWhere(
      (
        e,
      ) =>
          e.code ==
          statusCode,
      orElse: () => ErrorCode.unknown,
    );
  }
}

/// Model class for API errors with enhanced functionality
class ApiError
    implements
        Exception {
  final String
  message;
  final int?
  statusCode;
  final ErrorCode?
  errorCode;
  final dynamic
  originalError;
  final StackTrace?
  stackTrace;

  ApiError({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.originalError,
    this.stackTrace,
  });

  /// Factory constructor to create ApiError from JSON
  factory ApiError.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final statusCode =
        json['status_code']
            as int?;
    return ApiError(
      message:
          json['message'] ??
          'Unknown error occurred',
      statusCode: statusCode,
      errorCode:
          statusCode !=
              null
          ? ErrorCode.fromStatusCode(
              statusCode,
            )
          : null,
    );
  }

  /// Check if the error is a network-related error
  bool
  get isNetworkError =>
      message.contains(
        'internet',
      ) ||
      message.contains(
        'connection',
      );

  /// Check if the error is a validation error
  bool
  get isValidationError =>
      errorCode ==
      ErrorCode.validationFailed;

  /// Check if the error is an authentication error
  bool
  get isAuthenticationError =>
      errorCode ==
      ErrorCode.unauthorized;

  /// Check if the error is a server error
  bool
  get isServerError =>
      errorCode ==
      ErrorCode.serverError;

  /// Get user-friendly error message
  String
  getUserFriendlyMessage() {
    if (isNetworkError) {
      return 'Please check your internet connection and try again.';
    }
    if (isAuthenticationError) {
      return 'Invalid email or password. Please try again.';
    }
    if (isServerError) {
      return 'Server is currently unavailable. Please try again later.';
    }
    if (isValidationError) {
      return 'Please check your input and try again.';
    }
    return message;
  }

  /// Convert to JSON
  Map<
    String,
    dynamic
  >
  toJson() => {
    'message':
        message,
    'status_code':
        statusCode,
    'error_code':
        errorCode?.code,
  };

  @override
  String
  toString() =>
      'ApiError: $message'
      '${statusCode != null ? ' (Status Code: $statusCode)' : ''}'
      '${errorCode != null ? ' - ${errorCode!.description}' : ''}';
}
