// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
    Stu stu;
    String accessToken;
    String refreshToken;

    StudentModel({
        required this.stu,
        required this.accessToken,
        required this.refreshToken,
    });

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        stu: Stu.fromJson(json["stu"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "stu": stu.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}

class Stu {
    String id;
    String name;
    String email;
    String username;
    String phone;
    String faculty;
    String program;
    String sex;
    int yearofstudy;
    DateTime createdAt;
    DateTime updatedAt;

    Stu({
        required this.id,
        required this.name,
        required this.email,
        required this.username,
        required this.phone,
        required this.faculty,
        required this.program,
        required this.sex,
        required this.yearofstudy,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Stu.fromJson(Map<String, dynamic> json) => Stu(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        faculty: json["faculty"],
        program: json["program"],
        sex: json["sex"],
        yearofstudy: json["yearofstudy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "faculty": faculty,
        "program": program,
        "sex": sex,
        "yearofstudy": yearofstudy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
