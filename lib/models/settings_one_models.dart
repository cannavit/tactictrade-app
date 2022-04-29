// To parse this JSON data, do
//
//     final settingsOneModel = settingsOneModelFromMap(jsonString);

import 'dart:convert';

class SettingsOneModel {
    SettingsOneModel({
        required this.id,
        required this.setting,
        required this.family,
        required this.isActive,
        required this.boolValue,
        required this.stringValue,
        required this.icon,
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
    dynamic stringValue;
    String icon;
    bool isSwitchOn;
    DateTime createAt;
    DateTime updatedAt;
    int owner;

    factory SettingsOneModel.fromJson(String str) => SettingsOneModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SettingsOneModel.fromMap(Map<String, dynamic> json) => SettingsOneModel(
        id: json["id"],
        setting: json["setting"],
        family: json["family"],
        isActive: json["is_active"],
        boolValue: json["bool_value"],
        stringValue: json["string_value"],
        icon: json["icon"],
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
        "string_value": stringValue,
        "icon": icon,
        "is_switch_on": isSwitchOn,
        "create_at": createAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "owner": owner,
    };
}
