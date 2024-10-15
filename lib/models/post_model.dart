// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    String stskill;
    String stability;
    String stworktime;
    String id;
    // DateTime createdAt;
    // DateTime updatedAt;

    PostModel({
        required this.stskill,
        required this.stability,
        required this.stworktime,
        required this.id,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        stskill: json["stskill"],
        stability: json["stability"],
        stworktime: json["stworktime"],
        id: json["_id"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "stskill": stskill,
        "stability": stability,
        "stworktime": stworktime,
        "_id": id,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
    };
}
