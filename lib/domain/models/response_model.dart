class ResponseModel<T> {
  final T? data;
  final String message;
  final int code;

  ResponseModel({
    required this.code,
    required this.data,
    required this.message,
  });
}
