import 'package:cinemaapp/infrastructure/datasources/MoviedbDatasource/movidedb_datasocurce.dart';
import 'package:cinemaapp/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImplementation(MovidedbDatasocurce());
});
