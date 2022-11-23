// To parse this JSON data, do
//
//     final otherProfile = otherProfileFromJson(jsonString);

import 'dart:convert';

OtherProfile otherProfileFromJson(String str) => OtherProfile.fromJson(json.decode(str));

String otherProfileToJson(OtherProfile data) => json.encode(data.toJson());

class OtherProfile {
    String nickName;
    String imgUrl;
    String backgroundColor;
    String frase;
    List<String> followers;
    List<String> following;
    String friendOrNot;

    OtherProfile({
        this.nickName,
        this.imgUrl,
        this.backgroundColor,
        this.frase,
        this.followers,
        this.following,
        this.friendOrNot,
    });

    OtherProfile copyWith({
        String nickName,
        String imgUrl,
        String backgroundColor,
        String frase,
        List<String> followers,
        List<String> following,
        String friendOrNot,
    }) => 
        OtherProfile(
            nickName: nickName ?? this.nickName,
            imgUrl: imgUrl ?? this.imgUrl,
            backgroundColor: backgroundColor ?? this.backgroundColor,
            frase: frase ?? this.frase,
            followers: followers ?? this.followers,
            following: following ?? this.following,
            friendOrNot: friendOrNot ?? this.friendOrNot,
        );

    factory OtherProfile.fromJson(Map<String, dynamic> json) => OtherProfile(
        nickName: json["nickName"] == null ? null : json["nickName"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        backgroundColor: json["backgroundColor"] == null ? null : json["backgroundColor"],
        frase: json["frase"] == null ? null : json["frase"],
        followers: json["followers"] == null ? null : List<String>.from(json["followers"].map((x) => x)),
        following: json["following"] == null ? null : List<String>.from(json["following"].map((x) => x)),
        friendOrNot: json["friendOrNot"] == null ? null : json["friendOrNot"],
    );

    Map<String, dynamic> toJson() => {
        "nickName": nickName == null ? null : nickName,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "backgroundColor": backgroundColor == null ? null : backgroundColor,
        "frase": frase == null ? null : frase,
        "followers": followers == null ? null : List<dynamic>.from(followers.map((x) => x)),
        "following": following == null ? null : List<dynamic>.from(following.map((x) => x)),
        "friendOrNot": friendOrNot == null ? null : friendOrNot,
    };
}