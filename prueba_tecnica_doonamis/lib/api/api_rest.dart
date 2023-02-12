import 'dart:convert';
import '../classes/tv_show.dart';
import 'api_exec.dart';

class APIRest {
  static Future<List<TVShow>> getPopularTVShows({required int page}) async {
    try {
      final response = await APIExec.get(endpoint: 'popular', page: page);
      final decodedBody = jsonDecode(response) as Map<String, dynamic>;
      var showsAPI = decodedBody['results'] as List;
      List<TVShow> tvShows = showsAPI.map((i) => TVShow.fromMap(i)).toList();
      return tvShows;
    } catch (e) {
      rethrow;
    }
  }
}
