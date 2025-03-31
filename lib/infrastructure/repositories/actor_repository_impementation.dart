

import 'package:cinemaapp/domain/datasources/actors_datasource.dart';
import 'package:cinemaapp/domain/entities/actor.dart';
import 'package:cinemaapp/domain/repositories/actors_repository.dart';

class ActorRepositoryImpementation extends ActorsRepository{

  final ActorsDatasource actorsDatasource;
  ActorRepositoryImpementation(this.actorsDatasource);
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}