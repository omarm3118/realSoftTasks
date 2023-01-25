import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  late final String message;

   ErrorMessageModel({
    String? message,
  }) {
    this.message = message ?? 'some thing went wrong';
  }


  @override
  List<Object> get props => [message ?? 'some thing went wrong'];
}
