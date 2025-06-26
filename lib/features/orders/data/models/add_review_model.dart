import 'package:json_annotation/json_annotation.dart';
import 'package:servicex/features/orders/domain/entities/add_review_entity.dart';
part 'add_review_model.g.dart';

@JsonSerializable()
class AddReviewModel {
  String message;
  AddReviewModel({required this.message});

  factory AddReviewModel.fromJson(Map<String, dynamic> json) =>
      _$AddReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddReviewModelToJson(this);

  AddReviewEntity toAddReviewEntity() {
    return AddReviewEntity(message: message);
  }
}
