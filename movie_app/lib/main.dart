// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MovieApp());
}

// Movie Info

class MovieInfo {
  final adult,
      backdropPath,
      genreIds,
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      video,
      voteAverage,
      voteCount;

  MovieInfo.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'],
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}

class MovieGenreInfo {
  final List<dynamic> genres;
  MovieGenreInfo.fromJson(Map<String, dynamic> json) : genres = json['genres'];
}

class MovieSection {
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";
}

class MovieApi {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500/";

  static Future<List<MovieInfo>> getMovies(String kind) async {
    List<MovieInfo> moviesInstance = [];

    final url = Uri.parse('$baseUrl/$kind');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final List<dynamic> movies = responseJson['results'];
      for (var movie in movies) {
        moviesInstance.add(MovieInfo.fromJson(movie));
      }
      return moviesInstance;
    }
    throw Error();
  }

  static Future<MovieGenreInfo> getMovie(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic genres = jsonDecode(response.body);
      return MovieGenreInfo.fromJson(genres);
    }
    throw Error();
  }
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieWidget(),
    );
  }
}

class MovieWidget extends StatefulWidget {
  const MovieWidget({super.key});

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  late final Future<List<MovieInfo>> popularMovies;
  late final Future<List<MovieInfo>> nowPlayingMovies;
  late final Future<List<MovieInfo>> comingSoonMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = MovieApi.getMovies(MovieSection.popular);
    nowPlayingMovies = MovieApi.getMovies(MovieSection.nowPlaying);
    comingSoonMovies = MovieApi.getMovies(MovieSection.comingSoon);
  }

  // Home Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 70,
            top: 70,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Popular Movies',
                ),
                const SizedBox(height: 30),
                MakeMovies(
                  movies: popularMovies,
                  aspectRatio: 16 / 11.5,
                  height: 250,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Now in Cinemas',
                ),
                const SizedBox(height: 24),
                MakeMovies(
                  movies: nowPlayingMovies,
                  aspectRatio: 10 / 10.9,
                  height: 180,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Comming soon',
                ),
                const SizedBox(height: 24),
                MakeMovies(
                  movies: comingSoonMovies,
                  aspectRatio: 10 / 10.9,
                  height: 180,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Movie Poster

class MakeMovies extends StatelessWidget {
  final double aspectRatio;
  final double height;
  const MakeMovies({
    Key? key,
    required this.movies,
    required this.aspectRatio,
    required this.height,
  }) : super(key: key);

  final Future<List<MovieInfo>> movies;

  void _onMovieTap(BuildContext context, MovieInfo movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetail(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          voteAverage: movie.voteAverage,
          backdropPath: '${MovieApi.baseImageUrl}${movie.backdropPath}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: height,
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () => _onMovieTap(context, movie),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 60,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      },
    );
  }
}

// Movie Detail

class MovieDetail extends StatefulWidget {
  final String title, backdropPath, overview;
  final int id;
  final num voteAverage;

  const MovieDetail({
    super.key,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.id,
    required this.voteAverage,
  });

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool isGreen = Random().nextBool();

  late final int fullStar;
  late final bool hasHalfStar;

  late final Future<MovieGenreInfo> genres;

  void _backToHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    genres = MovieApi.getMovie(widget.id);
    fullStar = (widget.voteAverage / 2).floor();
    hasHalfStar = (widget.voteAverage / 2 - fullStar).round() == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Opacity(
              opacity: 0.9,
              child: Image.network(
                widget.backdropPath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          onPressed: () => _backToHome(context),
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 44,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          "Back to list",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 2.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 250),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          for (var count in [1, 2, 3, 4, 5])
                            Icon(
                              hasHalfStar && count == fullStar + 1
                                  ? Icons.star_half_rounded
                                  : Icons.star_rounded,
                              color: count <= (fullStar + (hasHalfStar ? 1 : 0))
                                  ? Colors.amber
                                  : Colors.grey.shade600,
                              size: 30,
                            ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      FutureBuilder(
                        future: genres,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(children: [
                              const Text(
                                '2h 14min | ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (var genre in snapshot.data!.genres)
                                        Text(
                                          genre['name'] + ", ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                            ]);
                          }
                          return const Text('Loading...');
                        },
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Sotryline',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.overview,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 75,
            bottom: 35,
            child: Container(
              width: 280,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Buy ticket',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
