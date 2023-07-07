import 'package:codefactory_flutte_project/common/component/pagination_list_view.dart';
import 'package:codefactory_flutte_project/product/component/product_card.dart';
import 'package:codefactory_flutte_project/product/model/product_model.dart';
import 'package:codefactory_flutte_project/product/provider/product_provider.dart';
import 'package:flutter/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return ProductCard.fromProductModel(model: model);
      },
    );
  }
}
