import 'package:dio/dio.dart';
import 'package:second_task_cleancode/core/network/error_message_model.dart';
import 'package:second_task_cleancode/movies/data/models/movie_model.dart';

import '../../../core/error/exceptions.dart';

abstract class BaseMovieRemoteDataSource {
  getNowPlayingMovies({required String endPoint,required Map<String,dynamic> parameter });
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSource(this._dio);

  @override
  Future<List<MovieModel>> getNowPlayingMovies({required String endPoint,required Map<String,dynamic>? parameter}) async {
    Response? response;
    try {
      response = await _dio.get(endPoint,queryParameters: parameter);
      if (response.statusCode == 200) {
        return List.from(response.data['results'] as List)
            .map((element) => MovieModel.fromJson(data: element)).toList();
      } else {
        throw ServerException(
          ErrorMessageModel.fromJson(data: response.data),
        );
      }
    } catch (error) {
      throw ServerException(
        ErrorMessageModel.fromJson(data: response?.data),
      );
    }
  }
  Future<List<MovieModel>> getTopRatedMovies({required String endPoint,required Map<String,dynamic>? parameter}) async {
    Response? response;
    try {
      response = await _dio.get(endPoint,queryParameters: parameter);
      if (response.statusCode == 200) {
        return List.from(response.data['results'] as List)
            .map((element) => MovieModel.fromJson(data: element)).toList();
      } else {
        throw ServerException(
          ErrorMessageModel.fromJson(data: response.data),
        );
      }
    } catch (error) {
      throw ServerException(
        ErrorMessageModel.fromJson(data: response?.data),
      );
    }
  }


  Future<List<MovieModel>> getPopularMovies({required String endPoint,required Map<String,dynamic>? parameter}) async {
    Response? response;
    try {
      response = await _dio.get(endPoint,queryParameters: parameter);
      if (response.statusCode == 200) {
        return List.from(response.data['results'] as List)
            .map((element) => MovieModel.fromJson(data: element)).toList();
      } else {
        throw ServerException(
          ErrorMessageModel.fromJson(data: response.data),
        );
      }
    } catch (error) {
      throw ServerException(
        ErrorMessageModel.fromJson(data: response?.data),
      );
    }
  }

}
