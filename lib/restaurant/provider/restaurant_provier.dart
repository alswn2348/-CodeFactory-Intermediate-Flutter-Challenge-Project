import 'package:codefactory_flutte_project/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutte_project/common/model/pagination_params.dart';
import 'package:codefactory_flutte_project/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        ) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    //데이터 추가
    bool fetchMore = false,

    //강제 로딩
    //true == CursorpaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      //CursorPagination - 데이터가 있는 상태
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        //바로반환하는 상황 추가로 가져올 데이터가 없을때
        if (!pState.meta.hasMore) return;
      }
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorpaginationFetchingMore;

      //바로반환하는 상황  fetchMore = true 이면서 로딩상태일때
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) return;

      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      //CursorPaginationLoading - 데이터 로딩중
      //CursorPaginationError - 에러
      //CursorPaginationRefetching - 다시 데이터 가져올때

      //CursorPaginationFetchMore - 추가 데이터 요청 받았을때
      if (fetchMore) {
        final pState = state as CursorPagination;

        //state  상태 변경
        state = CursorpaginationFetchingMore(
          data: pState.data,
          meta: pState.meta,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      //데이터를 처음부터 가져오는 상황
      if (!fetchMore) {
        //강제 새로고침
        if (forceRefetch) {
          state = CursorPaginationLoading();
        }
        //데이터가 있고 보존한채로 Fetch 할때
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            data: pState.data,
            meta: pState.meta,
          );
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorpaginationFetchingMore) {
        final pState = state as CursorpaginationFetchingMore;

        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      }
      if (state is CursorPaginationRefetching ||
          state is CursorPaginationLoading) {
        state = resp;
      }
    } catch (e) {
      state = CursorpaginationError(message: "데이터를 가져오지 못헀습니다.");
    }
  }
}
