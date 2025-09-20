import 'dart:convert';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static Future<List<UserModel>> fetchUsers() async {
    final res = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['data'] as List;
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('API Error');
    }
  }
}
