import 'package:json_annotation/json_annotation.dart';

part 'rate_model.g.dart';

@JsonSerializable()
class RateModel {
  final int? total;
  num avg;

  RateModel(this.total, this.avg);

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);
}
