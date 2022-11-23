// To parse this JSON data, do
//
//     final cityInfo = cityInfoFromJson(jsonString);

import 'dart:convert';

CityInfo cityInfoFromJson(String str) => CityInfo.fromJson(json.decode(str));

String cityInfoToJson(CityInfo data) => json.encode(data.toJson());

class CityInfo {
    String uniqueId;
    String cityName;
    int cityPopulation;
    int cityGeonameId;
    String countryName;
    String countryIso3;
    int countryPopulation;
    String countryCurrency;
    int countryGeonameId;
    ScoreData scoreData;
    List<String> images;

    CityInfo({
        this.cityName,
        this.cityPopulation,
        this.cityGeonameId,
        this.countryName,
        this.countryIso3,
        this.countryPopulation,
        this.countryCurrency,
        this.countryGeonameId,
        this.scoreData,
        this.images,
    });

    CityInfo copyWith({
        String cityName,
        int cityPopulation,
        int cityGeonameId,
        String countryName,
        String countryIso3,
        int countryPopulation,
        String countryCurrency,
        int countryGeonameId,
        ScoreData scoreData,
        List<String> images,
    }) => 
        CityInfo(
            cityName: cityName ?? this.cityName,
            cityPopulation: cityPopulation ?? this.cityPopulation,
            cityGeonameId: cityGeonameId ?? this.cityGeonameId,
            countryName: countryName ?? this.countryName,
            countryIso3: countryIso3 ?? this.countryIso3,
            countryPopulation: countryPopulation ?? this.countryPopulation,
            countryCurrency: countryCurrency ?? this.countryCurrency,
            countryGeonameId: countryGeonameId ?? this.countryGeonameId,
            scoreData: scoreData ?? this.scoreData,
            images: images ?? this.images,
        );

    factory CityInfo.fromJson(Map<String, dynamic> json) => CityInfo(
        cityName: json["cityName"] == null ? null : json["cityName"],
        cityPopulation: json["cityPopulation"] == null ? null : json["cityPopulation"],
        cityGeonameId: json["cityGeoname_id"] == null ? null : json["cityGeoname_id"],
        countryName: json["countryName"] == null ? null : json["countryName"],
        countryIso3: json["countryIso3"] == null ? null : json["countryIso3"],
        countryPopulation: json["countryPopulation"] == null ? null : json["countryPopulation"],
        countryCurrency: json["countryCurrency"] == null ? null : json["countryCurrency"],
        countryGeonameId: json["countryGeoname_id"] == null ? null : json["countryGeoname_id"],
        scoreData: json["scoreData"] == null ? null : ScoreData.fromJson(json["scoreData"]),
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "cityName": cityName == null ? null : cityName,
        "cityPopulation": cityPopulation == null ? null : cityPopulation,
        "cityGeoname_id": cityGeonameId == null ? null : cityGeonameId,
        "countryName": countryName == null ? null : countryName,
        "countryIso3": countryIso3 == null ? null : countryIso3,
        "countryPopulation": countryPopulation == null ? null : countryPopulation,
        "countryCurrency": countryCurrency == null ? null : countryCurrency,
        "countryGeoname_id": countryGeonameId == null ? null : countryGeonameId,
        "scoreData": scoreData == null ? null : scoreData.toJson(),
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    };
}

class ScoreData {
    List<ScoreInfo> scoreInfo;
    String summary;

    ScoreData({
        this.scoreInfo,
        this.summary,
    });

    ScoreData copyWith({
        List<ScoreInfo> scoreInfo,
        String summary,
    }) => 
        ScoreData(
            scoreInfo: scoreInfo ?? this.scoreInfo,
            summary: summary ?? this.summary,
        );

    factory ScoreData.fromJson(Map<String, dynamic> json) => ScoreData(
        scoreInfo: json["scoreInfo"] == null ? null : List<ScoreInfo>.from(json["scoreInfo"].map((x) => ScoreInfo.fromJson(x))),
        summary: json["summary"] == null ? null : json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "scoreInfo": scoreInfo == null ? null : List<dynamic>.from(scoreInfo.map((x) => x.toJson())),
        "summary": summary == null ? null : summary,
    };
}

class ScoreInfo {
    String color;
    String name;
    double scoreOutOf10;

    ScoreInfo({
        this.color,
        this.name,
        this.scoreOutOf10,
    });

    ScoreInfo copyWith({
        String color,
        String name,
        double scoreOutOf10,
    }) => 
        ScoreInfo(
            color: color ?? this.color,
            name: name ?? this.name,
            scoreOutOf10: scoreOutOf10 ?? this.scoreOutOf10,
        );

    factory ScoreInfo.fromJson(Map<String, dynamic> json) => ScoreInfo(
        color: json["color"] == null ? null : json["color"],
        name: json["name"] == null ? null : json["name"],
        scoreOutOf10: json["score_out_of_10"] == null ? null : json["score_out_of_10"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "color": color == null ? null : color,
        "name": name == null ? null : name,
        "score_out_of_10": scoreOutOf10 == null ? null : scoreOutOf10,
    };
}