import 'package:second_task_cleancode/movies/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.title,
    required super.id,
    required super.overview,
    required super.imageUrl,
  });

  factory MovieModel.fromJson({required Map<String, dynamic> data}) {
    return MovieModel(
      title: data['title'],
      id: data['id'],
      overview: data['overview'],
      imageUrl: data['backdrop_path'],
    );
  }
}
