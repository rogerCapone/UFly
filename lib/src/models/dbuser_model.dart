// To parse this JSON data, do
//
//     final dbUser = dbUserFromJson(jsonString);

import 'dart:convert';

DbUser dbUserFromJson(String str) => DbUser.fromJson(json.decode(str));

String dbUserToJson(DbUser data) => json.encode(data.toJson());

class DbUser {
    String uid;
    String userEmail;
    String userName;
    String nickName;
    String imgUrl;
    String frase;
    String backgroundColor;
    String tokenId;
    List<String> following;
    List<String> followers;
    List<String> pendingToAccept;
    String userWeb;
    String phoneNumber;
    int notificationsCount;
    List<NotificationsRegister> notificationsRegister;
    List<SubscriptionsRegister> subscriptionsRegister;

    DbUser({
        this.uid,
        this.userEmail,
        this.userName,
        this.nickName,
        this.imgUrl,
        this.frase,
        this.backgroundColor,
        this.tokenId,
        this.following,
        this.followers,
        this.pendingToAccept,
        this.userWeb,
        this.phoneNumber,
        this.notificationsCount,
        this.notificationsRegister,
        this.subscriptionsRegister,
    });

    DbUser copyWith({
        String uid,
        String userEmail,
        String userName,
        String nickName,
        String imgUrl,
        String frase,
        String backgroundColor,
        String tokenId,
        List<String> following,
        List<String> followers,
        List<String> pendingToAccept,
        String userWeb,
        String phoneNumber,
        int notificationsCount,
        List<NotificationsRegister> notificationsRegister,
        List<SubscriptionsRegister> subscriptionsRegister,
    }) => 
        DbUser(
            uid: uid ?? this.uid,
            userEmail: userEmail ?? this.userEmail,
            userName: userName ?? this.userName,
            nickName: nickName ?? this.nickName,
            imgUrl: imgUrl ?? this.imgUrl,
            frase: frase ?? this.frase,
            backgroundColor: backgroundColor ?? this.backgroundColor,
            tokenId: tokenId ?? this.tokenId,
            following: following ?? this.following,
            followers: followers ?? this.followers,
            pendingToAccept: pendingToAccept ?? this.pendingToAccept,
            userWeb: userWeb ?? this.userWeb,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            notificationsCount: notificationsCount ?? this.notificationsCount,
            notificationsRegister: notificationsRegister ?? this.notificationsRegister,
            subscriptionsRegister: subscriptionsRegister ?? this.subscriptionsRegister,
        );

    factory DbUser.fromJson(Map<String, dynamic> json) => DbUser(
        uid: json["uid"] == null ? null : json["uid"],
        userEmail: json["userEmail"] == null ? null : json["userEmail"],
        userName: json["userName"] == null ? null : json["userName"],
        nickName: json["nickName"] == null ? null : json["nickName"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        frase: json["frase"] == null ? null : json["frase"],
        backgroundColor: json["backgroundColor"] == null ? null : json["backgroundColor"],
        tokenId: json["tokenId"] == null ? null : json["tokenId"],
        following: json["following"] == null ? null : List<String>.from(json["following"].map((x) => x)),
        followers: json["followers"] == null ? null : List<String>.from(json["followers"].map((x) => x)),
        pendingToAccept: json["pendingToAccept"] == null ? null : List<String>.from(json["pendingToAccept"].map((x) => x)),
        userWeb: json["userWeb"] == null ? null : json["userWeb"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        notificationsCount: json["notificationsCount"] == null ? null : json["notificationsCount"],
        notificationsRegister: json["notificationsRegister"] == null ? null : List<NotificationsRegister>.from(json["notificationsRegister"].map((x) => NotificationsRegister.fromJson(x))),
        subscriptionsRegister: json["subscriptionsRegister"] == null ? null : List<SubscriptionsRegister>.from(json["subscriptionsRegister"].map((x) => SubscriptionsRegister.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "userEmail": userEmail == null ? null : userEmail,
        "userName": userName == null ? null : userName,
        "nickName": nickName == null ? null : nickName,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "frase": frase == null ? null : frase,
        "backgroundColor": backgroundColor == null ? null : backgroundColor,
        "tokenId": tokenId == null ? null : tokenId,
        "following": following == null ? null : List<dynamic>.from(following.map((x) => x)),
        "followers": followers == null ? null : List<dynamic>.from(followers.map((x) => x)),
        "pendingToAccept": pendingToAccept == null ? null : List<dynamic>.from(pendingToAccept.map((x) => x)),
        "userWeb": userWeb == null ? null : userWeb,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "notificationsCount": notificationsCount == null ? null : notificationsCount,
        "notificationsRegister": notificationsRegister == null ? null : List<dynamic>.from(notificationsRegister.map((x) => x.toJson())),
        "subscriptionsRegister": subscriptionsRegister == null ? null : List<dynamic>.from(subscriptionsRegister.map((x) => x.toJson())),
    };
}

class NotificationsRegister {
    String msg;
    String deep_link;

    NotificationsRegister({
        this.msg,
        this.deep_link,
    });

    NotificationsRegister copyWith({
        String msg,
        String deep_link,
    }) => 
        NotificationsRegister(
            msg: msg ?? this.msg,
            deep_link: deep_link ?? this.deep_link,
        );

    factory NotificationsRegister.fromJson(Map<String, dynamic> json) => NotificationsRegister(
        msg: json["msg"] == null ? null : json["msg"],
        deep_link: json["deep_link"] == null ? null : json["deep_link"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "deep_link": deep_link == null ? null : deep_link,
    };
}

class SubscriptionsRegister {
    String orig;
    String dest;
    int price;
    int dayInici;
    int monthInici;
    int yearInici;
    int dayFinal;
    int monthFinal;
    int yearFinal;

    SubscriptionsRegister({
        this.orig,
        this.dest,
        this.price,
        this.dayInici,
        this.monthInici,
        this.yearInici,
        this.dayFinal,
        this.monthFinal,
        this.yearFinal,
    });

    SubscriptionsRegister copyWith({
        String orig,
        String dest,
        int price,
        int dayInici,
        int monthInici,
        int yearInici,
        int dayFinal,
        int monthFinal,
        int yearFinal,
    }) => 
        SubscriptionsRegister(
            orig: orig ?? this.orig,
            dest: dest ?? this.dest,
            price: price ?? this.price,
            dayInici: dayInici ?? this.dayInici,
            monthInici: monthInici ?? this.monthInici,
            yearInici: yearInici ?? this.yearInici,
            dayFinal: dayFinal ?? this.dayFinal,
            monthFinal: monthFinal ?? this.monthFinal,
            yearFinal: yearFinal ?? this.yearFinal,
        );

    factory SubscriptionsRegister.fromJson(Map<String, dynamic> json) => SubscriptionsRegister(
        orig: json["orig"] == null ? null : json["orig"],
        dest: json["dest"] == null ? null : json["dest"],
        price: json["price"] == null ? null : json["price"],
        dayInici: json["dayInici"] == null ? null : json["dayInici"],
        monthInici: json["monthInici"] == null ? null : json["monthInici"],
        yearInici: json["yearInici"] == null ? null : json["yearInici"],
        dayFinal: json["dayFinal"] == null ? null : json["dayFinal"],
        monthFinal: json["monthFinal"] == null ? null : json["monthFinal"],
        yearFinal: json["yearFinal"] == null ? null : json["yearFinal"],
    );

    Map<String, dynamic> toJson() => {
        "orig": orig == null ? null : orig,
        "dest": dest == null ? null : dest,
        "price": price == null ? null : price,
        "dayInici": dayInici == null ? null : dayInici,
        "monthInici": monthInici == null ? null : monthInici,
        "yearInici": yearInici == null ? null : yearInici,
        "dayFinal": dayFinal == null ? null : dayFinal,
        "monthFinal": monthFinal == null ? null : monthFinal,
        "yearFinal": yearFinal == null ? null : yearFinal,
    };
}