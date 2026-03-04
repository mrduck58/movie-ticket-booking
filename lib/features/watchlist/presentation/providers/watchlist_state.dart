import '../../domain/entities/movie.dart';

class WatchlistState {
  final List<Movie> watchlist;
  final List<Movie> watched;

  const WatchlistState({
    required this.watchlist,
    required this.watched,
  });
}