import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovie;
  SearchMovieDelegate({required this.searchMovie});

  StreamController<List<Movie>> debounceMovies =
      StreamController<List<Movie>>.broadcast();
  Timer? _debounce;

  void _onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      //aaaaaaa
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }
      final movies = await searchMovie(query);
      debounceMovies.add(movies);
    });
  }

  @override
  String? get searchFieldLabel => 'Buscar Peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 300),
          child: IconButton(
              onPressed: () => query = '', icon: const Icon(Icons.clear))),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_ios_new),
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('buildResults'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movie = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (context, index) {
            final movies = movie[index];
            return GestureDetector(
                onTap: () => context.push('/movie/${movies.id}'),
                child: FadeInDown(child: _MovieItem(movie: movies)));
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final tesStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: tesStyle.titleMedium),
                const SizedBox(height: 5),
                Text(movie.overview,
                    maxLines: 3, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow[700]),
                    Text(movie.voteAverage.toString(),
                        style: tesStyle.bodySmall),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
