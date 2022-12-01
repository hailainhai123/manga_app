import 'package:json_annotation/json_annotation.dart';
import 'package:manga_app/models/home/new_model/categories_novel_model.dart';
import 'package:manga_app/models/home/new_model/cover_novel_model.dart';
import 'package:manga_app/models/home/new_model/rate_model.dart';

part 'novel_response_model.g.dart';

@JsonSerializable()
class ComicResponseModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? slugId;
  final String? name;
  final List<CoverNovelModel>? cover;
  final String? description;
  final String? shortDescription;
  final String? createdAt;
  final String? updatedAt;
  final bool? published;
  final String? status;
  final List<CategoriesNovelModel>? categories;
  final List<String>? tags;
  final int? lastChapter;
  final int? totalViews;
  final RateModel? rate;
  final int? followers;

  ComicResponseModel(
      {this.id,
      this.slugId,
      this.name,
      this.cover,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.published,
      this.status,
      this.categories,
      this.tags,
      this.shortDescription,
      this.lastChapter,
      this.totalViews,
      this.rate,
      this.followers});

  factory ComicResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ComicResponseModelFromJson(json);
}
