import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String theMovieKey= dotenv.env['MOVIEDB_KEY'] ?? 'No se encontro llave';
}