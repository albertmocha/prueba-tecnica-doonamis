import 'package:http/http.dart' as http;
import '../global/global.dart';

class APIExec {
  static Future<String> get({required String endpoint, int? page}) async {
    try {
      String pageStr = '';
      if (page != null) {
        pageStr = 'page=$page';
      }
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/$endpoint?api_key=${Global.apiKey}&language=${Global.language}&$pageStr'),
      );
      if (response.statusCode != 200) {
        throw Exception('Error al obtener los datos');
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
