// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

List<UsersData> usersDataFromJson(String str) => List<UsersData>.from(json.decode(str).map((x) => UsersData.fromJson(x)));

String usersDataToJson(List<UsersData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersData {
    String nickName;
    String img;
    String uid;
    String frase;

    UsersData({
        this.nickName,
        this.img,
        this.uid,
        this.frase,
    });

    UsersData copyWith({
        String nickName,
        String img,
        String uid,
        String frase,
    }) => 
        UsersData(
            nickName: nickName ?? this.nickName,
            img: img ?? this.img,
            uid: uid ?? this.uid,
            frase: frase ?? this.frase,
        );

    factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
        nickName: json["nickName"] == null ? null : json["nickName"],
        img: json["img"] == null ? null : json["img"],
        uid: json["uid"] == null ? null : json["uid"],
        frase: json["frase"] == null ? null : json["frase"],
    );

    Map<String, dynamic> toJson() => {
        "nickName": nickName == null ? null : nickName,
        "img": img == null ? null : img,
        "uid": uid == null ? null : uid,
        "frase": frase == null ? null : frase,
    };
}