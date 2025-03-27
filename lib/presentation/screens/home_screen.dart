import 'package:animate_do/animate_do.dart';
import 'package:cinemaapp/presentation/providers/movies/initial_loading_providers.dart';
import 'package:cinemaapp/presentation/providers/movies/movies_providers.dart';
import 'package:cinemaapp/presentation/widgets/movies/movies_horizontal_listView.dart';
import 'package:cinemaapp/presentation/widgets/shared/full_screen_loarder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movies/movies_slideshow_provider.dart';
import '../widgets/movies/movies_slideshow.dart';
import '../widgets/shared/custom_appbar.dart';
import '../widgets/shared/custom_botton_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottonNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesNotifierProvider.notifier).loandNextPage();
    ref.read(getPopularMoviesNotifierProvider.notifier).loandNextPage();
    ref.read(topRatedMoviesNotifierProvider.notifier).loandNextPage();
    ref.read(upComingMoviesNotifierProvider.notifier).loandNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initiaLoading = ref.watch(initialLoadingProvider);

    if (initiaLoading) {
      return FullScreenLoarder();
    }

    final nowPlayingMovies = ref.watch(nowPlayingMoviesNotifierProvider);
    final popularMovies = ref.watch(getPopularMoviesNotifierProvider);
    final topRateMovies = ref.watch(topRatedMoviesNotifierProvider);
    final upComingMovies = ref.watch(upComingMoviesNotifierProvider);
    final slideShowMovies = ref.watch(moviesSlideshow);

    return FadeIn(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideShowMovies),
                  MoviesHorizontal(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subtitle: 'Lunes 20',
                    loandNextPage: () {
                      ref
                          .read(nowPlayingMoviesNotifierProvider.notifier)
                          .loandNextPage();
                    },
                  ),
                  MoviesHorizontal(
                    movies: popularMovies,
                    title: 'Populares',
                    loandNextPage: () {
                      ref
                          .read(getPopularMoviesNotifierProvider.notifier)
                          .loandNextPage();
                    },
                  ),
                  MoviesHorizontal(
                    movies: topRateMovies,
                    title: 'Mejor calificadas',
                    loandNextPage: () {
                      ref
                          .read(topRatedMoviesNotifierProvider.notifier)
                          .loandNextPage();
                    },
                  ),
                  MoviesHorizontal(
                    movies: upComingMovies,
                    title: 'Proximamente', // Upcoming
                    loandNextPage: () {
                      ref
                          .read(upComingMoviesNotifierProvider.notifier)
                          .loandNextPage();
                    },
                  ),
                  SizedBox(height: 5)
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
