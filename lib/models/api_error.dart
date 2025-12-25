class ApiError {
  final String
  message;
  final int?
  statusCode;

  ApiError({
    required this.message,
    this.statusCode,
  });

  factory ApiError.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return ApiError(
      message:
          json['message'] ??
          'Unknown error occurred',
      statusCode: json['status_code'],
    );
  }
}
