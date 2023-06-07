import 'package:codefactory_flutte_project/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET("/")
  @Headers({
    'accesstoken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET("/{id}")
  @Headers({
    'accesstoken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}
