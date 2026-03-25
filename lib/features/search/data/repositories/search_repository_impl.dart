import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<SearchResultEntity> search(String keyword) async {
    final result = await datasource.search(keyword);

    return SearchResultEntity(
      cinemas: result.cinemas,
      movies: result.movies,
    );
  }
}