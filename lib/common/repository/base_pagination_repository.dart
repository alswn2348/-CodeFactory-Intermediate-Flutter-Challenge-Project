import 'package:codefactory_flutte_project/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutte_project/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
