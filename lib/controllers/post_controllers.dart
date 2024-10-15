import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jobstd_flutter/controllers/student_controllers.dart';
import 'package:jobstd_flutter/models/post_model.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:jobstd_flutter/varibles.dart';

class PostService {
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
  
  Future<void> _response(
      http.Response response, UserProvider userProvider) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 403) {
      await PostService().refreshToken(userProvider);
    } else if (response.statusCode == 401) {
      userProvider.onlogout();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Error : ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<PostModel>> fetchPosts(UserProvider userProvider) async {
    final response = await http.get(Uri.parse('$apiURL/api/poststudent'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userProvider.accessToken}',
    });

    await _response(response, userProvider);

    List<dynamic> postList = jsonDecode(response.body);
    return postList.map((json) => PostModel.fromJson(json)).toList();
  }

  Future<void> addPost(
      PostModel postModel, UserProvider userProvider) async {
    final response = await http.post(Uri.parse('$apiURL/api/poststudent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(postModel.toJson()));
    await _response(response, userProvider);
  }

  Future<void> updatePost(
      PostModel postModel, UserProvider userProvider) async {
    final response =
        await http.put(Uri.parse('$apiURL/api/poststudent/${postModel.id}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${userProvider.accessToken}',
            },
            body: jsonEncode(postModel.toJson()));
    await _response(response, userProvider);
  }

  Future<void> deletePost(
      String postModel_id, UserProvider userProvider) async {
    final response = await http.delete(
      Uri.parse('$apiURL/api/poststudent/${postModel_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userProvider.accessToken}',
      },
    );
    await _response(response, userProvider);
  }
}