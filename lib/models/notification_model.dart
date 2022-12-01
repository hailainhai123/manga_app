import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? title;
  String? content;
  String? link;

  NotificationModel(
      {this.id, this.createdAt, this.title, this.content, this.link});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
