import 'package:animate_do/animate_do.dart';
import 'package:cinemaapp/config/helpers/human_formats.dart';
import 'package:cinemaapp/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontal extends StatefulWidget {
  final List<Movie> movies;
  final String? title, subtitle;
  final VoidCallback? loandNextPage;
  const MoviesHorizontal(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loandNextPage});

  @override
  State<MoviesHorizontal> createState() => _MoviesHorizontalState();
}

class _MoviesHorizontalState extends State<MoviesHorizontal> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loandNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loandNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(titulo: widget.title, subtitulo: widget.subtitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slider(
                    movie: widget.movies[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final Movie movie;
  const _Slider({required this.movie});

  @override
  Widget build(BuildContext context) {
    final texStyle = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                height: 220,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          // titulo
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: texStyle.titleSmall,
            ),
          ),
          //rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  '${movie.voteAverage}',
                  style: texStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: texStyle.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? titulo, subtitulo;
  const _Title({this.titulo, this.subtitulo});

  @override
  Widget build(BuildContext context) {
    final tesStyle= Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          if (titulo != null) Text(titulo!,style: tesStyle.bodyLarge,),
          Spacer(),
          if (subtitulo != null)
            FilledButton(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subtitulo!))
        ],
      ),
    );
  }
}
