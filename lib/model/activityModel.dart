// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
    Activity({
        this.activity,
        this.type,
        this.participants,
        this.price,
        this.link,
        this.key,
        this.accessibility,
    });

    String activity;
    String type;
    dynamic participants;
    dynamic price;
    String link;
    String key;
    dynamic accessibility;

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activity: json["activity"] == null ? null : json["activity"],
        type: json["type"] == null ? null : json["type"],
        participants: json["participants"] == null ? null : json["participants"],
        price: json["price"] == null ? null : json["price"],
        link: json["link"] == null ? null : json["link"],
        key: json["key"] == null ? null : json["key"],
        accessibility: json["accessibility"] == null ? null : json["accessibility"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "activity": activity == null ? null : activity,
        "type": type == null ? null : type,
        "participants": participants == null ? null : participants,
        "price": price == null ? null : price,
        "link": link == null ? null : link,
        "key": key == null ? null : key,
        "accessibility": accessibility == null ? null : accessibility,
    };
}
