import 'package:cinemaapp/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:cinemaapp/presentation/widgets/shared/full_screen_loarder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/movies/movie_info_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const routeName = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loandMovie(widget.movieId);
    ref.read(actorbymovideProviders.notifier).loandActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return Scaffold(body: FullScreenLoarder());
    }
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: (size.width - 50) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.bodyLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      movie.overview,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        _ActorMovie(movie.id),
        SizedBox(height: 50),
      ],
    );
  }
}

class _ActorMovie extends ConsumerWidget {
  final int movieId;

  const _ActorMovie(this.movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorbymovideProviders)[movieId.toString()];
    final size = MediaQuery.of(context).size;
    if (actors == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              margin: EdgeInsets.all(10),
              width: size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Nombre del actor
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? 'Sin información',
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
          ],
        ),
      ),
    );
  }
}
