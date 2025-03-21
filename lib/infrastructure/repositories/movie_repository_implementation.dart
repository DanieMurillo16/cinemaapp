
import 'package:cinemaapp/domain/datasources/movies_datasource.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/domain/repositories/movies_repository.dart';

class MovieRepositoryImplementation  extends MoviesRepository{

  final MoviesDataSource dataSource;
  MovieRepositoryImplementation(this.dataSource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

}