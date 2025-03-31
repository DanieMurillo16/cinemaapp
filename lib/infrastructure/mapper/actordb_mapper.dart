import 'package:cinemaapp/infrastructure/models/moviedb/credist_response.dart';

import '../../domain/entities/actor.dart';

class ActordbMapper {
  static Actor actordbEntity(Cast actor) => Actor(
      id: actor.id,
      name: actor.name,
      profilePath: (actor.profilePath != '') && (actor.profilePath != null)
          ? 'https://image.tmdb.org/t/p/w500${actor.profilePath}'
          : 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
      character: actor.character);
}
