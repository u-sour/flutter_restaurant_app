import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import 'table_status_info.dart';
import 'table_widget.dart';

class SaleTableWidget extends StatelessWidget {
  const SaleTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    late int crossAxisCount;
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
    } else if (ResponsiveLayout.isTablet(context)) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 8;
    }
    return Column(
      children: [
        const TableStatusInfo(),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppStyleDefaultProperties.p),
              itemCount: 100,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: AppStyleDefaultProperties.h,
                  crossAxisSpacing: AppStyleDefaultProperties.w,
                  mainAxisExtent: 120.0,
                  crossAxisCount: crossAxisCount),
              itemBuilder: (context, index) {
                return TableWidget(
                  key: UniqueKey(),
                  countCustomer: 0,
                  maxChair: 5,
                  name: 'Table - $index',
                  onTap: () {},
                );
              }),
        ),
      ],
    );
  }
}
