// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromMap(jsonString);

import 'dart:convert';

class SettingsModel {
    SettingsModel({
        this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Setting> results;

    factory SettingsModel.fromJson(String str) => SettingsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SettingsModel.fromMap(Map<String, dynamic> json) => SettingsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Setting>.from(json["results"].map((x) => Setting.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Setting {
    Setting({
        required this.id,
        required this.setting,
        required this.family,
        required this.isActive,
        required this.boolValue,
        this.stringValue="",
        this.icon="",
        required this.isSwitchOn,
        required this.createAt,
        required this.updatedAt,
        required this.owner,
    });

    int id;
    String setting;
    String family;
    bool isActive;
    bool boolValue;
    String? stringValue;
    String? icon;
    bool isSwitchOn;
    DateTime createAt;
    DateTime updatedAt;
    int owner;

    factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        id: json["id"],
        setting: json["setting"],
        family: json["family"],
        isActive: json["is_active"],
        boolValue: json["bool_value"],
        stringValue: json["string_value"] == null ? null : json["string_value"],
        icon: json["icon"] == null ? null : json["icon"],
        isSwitchOn: json["is_switch_on"],
        createAt: DateTime.parse(json["create_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        owner: json["owner"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "setting": setting,
        "family": family,
        "is_active": isActive,
        "bool_value": boolValue,
        "string_value": stringValue == null ? null : stringValue,
        "icon": icon == null ? null : icon,
        "is_switch_on": isSwitchOn,
        "create_at": createAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "owner": owner,
    };
}
