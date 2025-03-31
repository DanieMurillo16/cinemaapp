
import 'package:cinemaapp/domain/entities/actor.dart';
import 'package:cinemaapp/presentation/providers/actors/actors_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorbymovideProviders = StateNotifierProvider<ActorsByMovieProvider, Map<String,List<Actor>>>((ref){
  final actorsRepository = ref.watch(actorRepositoryProviders);
  return ActorsByMovieProvider(getActors: actorsRepository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieProvider extends StateNotifier<Map<String,List<Actor>>> {

  final GetActorsCallback getActors;

  ActorsByMovieProvider({required this.getActors}) : super({});

  Future<void> loandActors(String movieId) async{
    if(state[movieId]!=null) return;
    final actores = await getActors(movieId);
    state = {...state, movieId: actores};

  }

}