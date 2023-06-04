import 'package:codefactory_flutte_project/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  /*  @GET("/")
  paginate(); */

  @GET("/{id}")
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path('id') required String id});
}
