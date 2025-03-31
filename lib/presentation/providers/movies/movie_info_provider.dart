
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String,Movie>>((ref){
  return MovieMapNotifier(getMovie: ref.watch(movieRepositoryProvider).getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loandMovie(String movieId) async{
    if(state[movieId]!=null) return;
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};

  }

}