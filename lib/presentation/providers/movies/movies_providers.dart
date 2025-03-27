import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesNotifierProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fecthMovies: fectMoreMovies);
});
final getPopularMoviesNotifierProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fecthMovies: fectMoreMovies);
});
final topRatedMoviesNotifierProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fecthMovies: fectMoreMovies);
});
final upComingMoviesNotifierProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fectMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fecthMovies: fectMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fecthMovies;

  MoviesNotifier({required this.fecthMovies}) : super([]);

  Future<void> loandNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final newMovies = await fecthMovies(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
