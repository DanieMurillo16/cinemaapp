import 'package:cinemaapp/config/constats/enviroment.dart';
import 'package:cinemaapp/domain/datasources/movies_datasource.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/infrastructure/mapper/moviedb_mapper.dart';
import 'package:cinemaapp/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MovidedbDatasocurce extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.theMovieKey,
        'language': 'es-ES'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movideDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movideDBResponse.results
        .where((movied)=>movied.posterPath != 'no-poster')
        .map((e) => MoviedbMapper.movieDBEntity(e))
        .toList();
    return movies;
  }
}
