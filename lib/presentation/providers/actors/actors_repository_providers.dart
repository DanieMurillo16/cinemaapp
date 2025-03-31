
import 'package:cinemaapp/infrastructure/datasources/MoviedbDatasource/actor_moviedb_datasource.dart';
import 'package:cinemaapp/infrastructure/repositories/actor_repository_impementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProviders = Provider((ref) {
  return ActorRepositoryImpementation(ActorMovieDatasource());
});