import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/api/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UserModel>> fetchUsers() async {
    final Uri url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw HttpException(
          'Failed to load users (Status Code: ${response.statusCode})',
        );
      }
    } on SocketException {
      throw const SocketException(
        'No Internet connection. Please check your network and try again.',
      );
    } on FormatException {
      throw const FormatException(
        'Bad response format received from the server.',
      );
    } catch (e) {
      if (e is HttpException || e is SocketException || e is FormatException) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
