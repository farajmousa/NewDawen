import 'dart:convert';

class ApiResponse {
  final int? status;
  final String? message;
  final Map<String, dynamic>? data;
  ApiResponse({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }

  static ApiResponse fromMap<T>(Map<String, dynamic>? map) {
    if (map == null) return ApiResponse();
    return ApiResponse(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'ApiResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ApiResponse &&
        o.status == status &&
        o.message == message &&
        o.data == data;
  }
}
