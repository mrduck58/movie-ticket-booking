
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/movie_interest_model.dart';

class MovieInterestNotifier extends StateNotifier<List<MovieInterestModel>> {

  MovieInterestNotifier()
      : super([
          const MovieInterestModel(name: "Action"),
          const MovieInterestModel(name: "Adventure"),
          const MovieInterestModel(name: "Comedy"),
          const MovieInterestModel(name: "Drama"),
          const MovieInterestModel(name: "Romance"),
          const MovieInterestModel(name: "Fantasy"),
          const MovieInterestModel(name: "Science Fiction"),
          const MovieInterestModel(name: "Thriller"),
          const MovieInterestModel(name: "War"),
          const MovieInterestModel(name: "Family"),
          const MovieInterestModel(name: "Spy"),
          const MovieInterestModel(name: "Travel"),
        ]);

  void toggleGenre(int index) {

    final updated = [...state];

    final item = updated[index];

    updated[index] =
        item.copyWith(isSelected: !item.isSelected);

    state = updated;
  }

  List<String> get selectedGenres =>
      state.where((g) => g.isSelected).map((e) => e.name).toList();
}

final movieInterestProvider =
    StateNotifierProvider<MovieInterestNotifier, List<MovieInterestModel>>(
  (ref) => MovieInterestNotifier(),
);

