import 'package:json_annotation/json_annotation.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel {
  @JsonKey(name: '_id')
  String? id;
  int? number;
  String? bookId;
  String? name;
  List<ContentComic>? content;
  String? createdAt;
  int? price;

  ChapterModel(
      {this.id,
      this.number,
      this.bookId,
      this.name,
      this.content,
      this.createdAt,
      this.price});

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}

@JsonSerializable()
class ContentComic {
  @JsonKey(name: '_id')
  String? id;
  String? url;
  String? name;

  ContentComic({this.id, this.url, this.name});

  factory ContentComic.fromJson(Map<String, dynamic> json) =>
      _$ContentComicFromJson(json);
}
