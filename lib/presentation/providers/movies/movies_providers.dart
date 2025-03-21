import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesNotifierProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fecthMovies: fectMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fecthMovies;

  MoviesNotifier({required this.fecthMovies}) : super([]);

  Future<void> loandNextPage() async {
    currentPage++;
    final newMovies = await fecthMovies(page: currentPage);
    state = [...state, ...newMovies];
  }
}
