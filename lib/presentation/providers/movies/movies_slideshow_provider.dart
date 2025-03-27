


import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshow = Provider<List<Movie>>((ref){
  final nowplayingMovies = ref.watch(nowPlayingMoviesNotifierProvider);

  if (nowplayingMovies.isEmpty){
    return [];
  }
  return nowplayingMovies.sublist(0,6);
}); 


