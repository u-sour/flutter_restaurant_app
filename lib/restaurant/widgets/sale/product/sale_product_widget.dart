import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import 'sale_product_item_widget.dart';

class SaleProductWidget extends StatelessWidget {
  final double? slidingUpPanelMinHeight;
  const SaleProductWidget({super.key, this.slidingUpPanelMinHeight});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    // Desktop mode
    int crossAxisCount = 3;
    double imageHeight = 150.0;
    // Tablet portrait mode
    if (ResponsiveLayout.isTablet(context)) {
      crossAxisCount = 4;
      imageHeight = 180.0;
    }
    //Tablet landscape mode
    if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 3;
      imageHeight = 145.0;
    }

    //Mobile portrait mode
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
      imageHeight = 180.0;
    }

    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Column(
        children: [
          Expanded(
            child: DynamicHeightGridView(
                itemCount: 50,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppStyleDefaultProperties.w,
                mainAxisSpacing: 0.0,
                builder: (context, index) {
                  return SaleProductItemWidget(
                    name: "Product $index",
                    imgHeight: imageHeight,
                    baseCurrency: "USD",
                    onTap: () {},
                    decimalNumber: 2,
                  );
                }),
          ),
          SizedBox(height: slidingUpPanelMinHeight)
        ],
      ),
    );
  }
}
