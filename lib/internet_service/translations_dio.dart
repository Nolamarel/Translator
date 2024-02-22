import 'package:dio/dio.dart';

class TranslationsDio {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> translateData(
      Map<String, dynamic> requestData) async {
    try {
      final response = await dio.post(
        'https://translate.api.cloud.yandex.net/translate/v2/translate',
        data: requestData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Api-Key AQVNwT-P5qsvyHGX5vlH9rmVyU6tuMRqsiggCUyP',
          },
        ),
      );

      if (response.statusCode == 200) {
        //print('response: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to translate data');
      }
    } catch (e) {
      throw Exception('Failed to make API call: $e');
    }
  }
}
