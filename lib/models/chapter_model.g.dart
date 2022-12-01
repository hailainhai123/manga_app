// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) => ChapterModel(
      id: json['_id'] as String?,
      number: json['number'] as int?,
      bookId: json['bookId'] as String?,
      name: json['name'] as String?,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ContentComic.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'number': instance.number,
      'bookId': instance.bookId,
      'name': instance.name,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'price': instance.price,
    };

ContentComic _$ContentComicFromJson(Map<String, dynamic> json) => ContentComic(
      id: json['_id'] as String?,
      url: json['url'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ContentComicToJson(ContentComic instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'url': instance.url,
      'name': instance.name,
    };
