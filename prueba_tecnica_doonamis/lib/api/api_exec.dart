import 'package:http/http.dart' as http;
import '../global/global.dart';

class APIExec {
  static Future<String> get(
      {required String endpoint, required int page}) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/$endpoint?api_key=${Global.apiKey}&language=en-US&page=$page'),
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
