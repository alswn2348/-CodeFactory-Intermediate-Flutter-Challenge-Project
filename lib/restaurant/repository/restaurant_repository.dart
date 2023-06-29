import 'package:codefactory_flutte_project/common/const/data.dart';
import 'package:codefactory_flutte_project/common/dio/dio.dart';
import 'package:codefactory_flutte_project/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutte_project/common/model/pagination_params.dart';
import 'package:codefactory_flutte_project/common/repository/base_pagination_repository.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/retaurant');

    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @override
  @GET("/")
  @Headers({
    'accesstoken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET("/{id}")
  @Headers({
    'accesstoken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}
