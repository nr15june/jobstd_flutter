//เก็บข้อมูลเกี่ยวกับล็อคอิน
import 'package:flutter/material.dart';
import 'package:jobstd_flutter/models/student_model.dart';

class UserProvider extends ChangeNotifier {
  Stu? _stu;
  String? _accessToken;
  String? _refreshToken;

  Stu get stu => _stu!;
  String get accessToken => _accessToken!;
  String get refreshToken => _refreshToken!;

  void onlogin(StudentModel studentModel) {
    _stu = studentModel.stu;
    _accessToken = studentModel.accessToken;
    _refreshToken= studentModel.refreshToken;
    notifyListeners();
  }

  void onlogout() {
    _stu = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }
  bool isAuthentication() {
    return _accessToken != null && _refreshToken != null;
  }

  void requestToken(String newToken) {
    _accessToken = newToken;
    notifyListeners();
  }
}


