class ApiResponse {
  final int statusCode;
  final dynamic responseData;
  final bool isScuccess;
  final String? errorMessage;
  ApiResponse({
    required this.statusCode,
    required this.responseData,
    required this.isScuccess,
    this.errorMessage,
  });

}
