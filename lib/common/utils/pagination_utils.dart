import 'package:codefactory_flutte_project/common/provider/pagination_provider.dart';
import 'package:flutter/material.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}
