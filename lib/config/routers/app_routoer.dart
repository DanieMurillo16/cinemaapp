import 'package:cinemaapp/presentation/screens/home_screen.dart';
import 'package:cinemaapp/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: 'movie/:id',
            name: MovieScreen.routeName,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(movieId: movieId);
            },
          ),
        ]),
  ],
);
