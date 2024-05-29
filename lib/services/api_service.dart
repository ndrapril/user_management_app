import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body)['data'];
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: json.encode({
        'name': name,
        'job': job,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }
}
