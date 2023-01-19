import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final int statusCode;

  const ErrorMessageModel({
    required this.message,
    required this.statusCode,
  });

  factory ErrorMessageModel.fromJson({required Map<String, dynamic>? data}) {
    return ErrorMessageModel(
      message: data != null ? data['status_message'] : 'something went wrong',
      statusCode: data != null ? data['status_code'] : 101,
    );
  }

  @override
  List<Object> get props => [message, statusCode];
}
