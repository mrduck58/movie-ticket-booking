import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/movie_interest_model.dart';

class MovieInterestNotifier extends StateNotifier<List<MovieInterestModel>> {
  MovieInterestNotifier()
    : super([
        MovieInterestModel(id: "GEN001", name: "Action"),
        MovieInterestModel(id: "GEN002", name: "Adventure"),
        MovieInterestModel(id: "GEN003", name: "Animation"),
        MovieInterestModel(id: "GEN004", name: "Biography"),
        MovieInterestModel(id: "GEN005", name: "Comedy"),
        MovieInterestModel(id: "GEN006", name: "Crime"),
        MovieInterestModel(id: "GEN007", name: "Documentary"),
        MovieInterestModel(id: "GEN008", name: "Drama"),
        MovieInterestModel(id: "GEN009", name: "Family"),
        MovieInterestModel(id: "GEN010", name: "Fantasy"),
        MovieInterestModel(id: "GEN011", name: "History"),
        MovieInterestModel(id: "GEN012", name: "Horror"),
        MovieInterestModel(id: "GEN013", name: "Music"),
        MovieInterestModel(id: "GEN014", name: "Mystery"),
        MovieInterestModel(id: "GEN015", name: "Romance"),
        MovieInterestModel(id: "GEN016", name: "Sci-Fi"),
        MovieInterestModel(id: "GEN017", name: "Sport"),
        MovieInterestModel(id: "GEN018", name: "Thriller"),
        MovieInterestModel(id: "GEN019", name: "War"),
        MovieInterestModel(id: "GEN020", name: "Western"),
        MovieInterestModel(id: "GEN021", name: "Superhero"),
        MovieInterestModel(id: "GEN022", name: "Psychological"),
        MovieInterestModel(id: "GEN023", name: "Anime"),
        MovieInterestModel(id: "GEN024", name: "Disaster"),
        MovieInterestModel(id: "GEN025", name: "Martial Arts"),
      ]);

  void toggleGenre(int index) {
    final updated = [...state];

    final item = updated[index];

    updated[index] = item.copyWith(isSelected: !item.isSelected);

    state = updated;
  }

  List<String> get selectedGenres =>
      state.where((g) => g.isSelected).map((e) => e.id).toList();
}

final movieInterestProvider =
    StateNotifierProvider<MovieInterestNotifier, List<MovieInterestModel>>(
      (ref) => MovieInterestNotifier(),
    );
