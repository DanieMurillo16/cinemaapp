import 'package:cinemaapp/presentation/providers/movies/movies_repositories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
          Row(
            children: [
              Icon(Icons.movie_outlined),
              Spacer(),
              Text('Cinema app'),
              Spacer(),
              IconButton(onPressed: (){
                final searchMovie = ref.read(movieRepositoryProvider);
                showSearch(context: context,
                 delegate: SearchMovieDelegate(searchMovie: searchMovie.searchMovies));
              }, icon: Icon(Icons.search))
              ,
            ],
          ),));
  }
}
