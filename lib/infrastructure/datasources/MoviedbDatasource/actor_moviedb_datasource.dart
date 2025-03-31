import 'package:cinemaapp/config/constats/enviroment.dart';
import 'package:cinemaapp/domain/datasources/actors_datasource.dart';
import 'package:cinemaapp/domain/entities/actor.dart';
import 'package:dio/dio.dart';

import '../../mapper/actordb_mapper.dart';
import '../../models/moviedb/credist_response.dart';

class ActorMovieDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.theMovieKey,
        'language': 'es-ES'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final actorbdResponse = CreditsResponse.fromJson(response.data);
    final List<Actor> actor = actorbdResponse.cast
        .map((e) => ActordbMapper.actordbEntity(e))
        .toList();
    return actor;
  }
}
