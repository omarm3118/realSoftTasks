import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final int id;
  final String overview;
  final String imageUrl;

  const MovieEntity({
    required this.title,
    required this.id,
    required this.overview,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [title, id, overview];
}
