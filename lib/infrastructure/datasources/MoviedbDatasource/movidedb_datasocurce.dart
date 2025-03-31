import 'package:cinemaapp/config/constats/enviroment.dart';
import 'package:cinemaapp/domain/datasources/movies_datasource.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/infrastructure/mapper/moviedb_mapper.dart';
import 'package:cinemaapp/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemaapp/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovidedbDatasocurce extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.theMovieKey,
        'language': 'es-ES'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movideDBResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movideDBResponse.results
        .where((movied) => movied.posterPath != 'no-poster')
        .map((e) => MoviedbMapper.movieDBEntity(e))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) {
      throw Exception('Error, no se encontro pelicula con ese id $movieId');
    }

    final movieDB = MovieDetails.fromJson(response.data);
    final Movie movie = MoviedbMapper.movieDetailsToEntity(movieDB);
    return movie;
  }
}
