import 'package:flutter/material.dart';
import 'package:jobstd_flutter/models/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:jobstd_flutter/varibles.dart';
import 'dart:convert';

class StudentService {
  Future<StudentModel?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiURL/api/student/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    print(response.statusCode); // ตรวจสอบสถานะ

    if (response.statusCode == 200) {
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
}

  //register
  Future<void> register(
      String name, String email, String username, String password, String phone, String faculty, String program, 
      String sex, int yearofstudy) async {
    final response = await http.post(
      Uri.parse('$apiURL/api/student/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'phone': phone,
        'faculty': faculty,
        'program': program,
        'sex': sex,
        'yearofstudy': yearofstudy
      }),
    );
    print(response.statusCode);
  }

  Future<void> refreshToken(UserProvider userProvider) async {
    final refreshToken = userProvider.refreshToken;

    print("Refresh Token: $refreshToken");
    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    }

    final response = await http.post(
      Uri.parse('$apiURL/api/student/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': refreshToken,
      }),
    );

    print("Refresh Response: ${response.statusCode} - ${response.body}");
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      userProvider.requestToken(responseData['accessToken']);
    } else {
      print('Failed to refresh token : ${response.body}');
      throw Exception('Failed to refresh token : ${response.body}');
    }
  }
}