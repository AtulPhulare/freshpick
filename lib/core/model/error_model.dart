
class ErrorModel {
  final bool? error;
  final String? message;

  ErrorModel({
     this.error,
     this.message,
  });

  
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }

  // Convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
    };
  }
}
