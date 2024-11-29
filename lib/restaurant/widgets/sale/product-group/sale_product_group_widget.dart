import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/product-group/sale_product_group_model.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import 'sale_product_group_item_widget.dart';

class SaleProductGroupWidget extends StatelessWidget {
  const SaleProductGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SaleProductsProvider readSaleProductsProvider =
        context.read<SaleProductsProvider>();
    return Selector<SaleProductsProvider, List<SaleProductGroupModel>>(
        selector: (context, state) => state.productGroup,
        builder: (context, productGroup, child) {
          return productGroup.isNotEmpty
              ? SizedBox(
                  height: AppStyleDefaultProperties.h * 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productGroup.length,
                      padding: const EdgeInsets.only(
                          bottom: AppStyleDefaultProperties.p),
                      itemBuilder: (context, index) {
                        final SaleProductGroupModel pg = productGroup[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: AppStyleDefaultProperties.p),
                          child: SaleProductGroupItemWidget(
                            productGroup: pg,
                            onPressed: () {
                              // Note: Check unselect product group
                              // if productGroupId already selected then unselected
                              readSaleProductsProvider.filter(
                                  productGroupId: pg.id !=
                                          readSaleProductsProvider
                                              .productGroupId
                                      ? pg.id
                                      : '',
                                  categoryId:
                                      readSaleProductsProvider.categoryId,
                                  search: readSaleProductsProvider.search);
                            },
                          ),
                        );
                      }),
                )
              : const SizedBox.shrink();
        });
  }
}
