import 'package:codefactory_flutte_project/common/model/model_with_id.dart';
import 'package:codefactory_flutte_project/common/utils/data_utils.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final int price;
  final RestaurantModel restaurant;
  ProductModel({
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
    required this.id,
    required this.name,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
