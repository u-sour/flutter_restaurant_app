import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../models/sale/category/sale_category_model.dart';
import '../../../utils/constants.dart';
import 'sale_category_item_widget.dart';

class SaleCategoryWidget extends StatefulWidget {
  const SaleCategoryWidget({super.key});

  @override
  State<SaleCategoryWidget> createState() => _SaleCategoryWidgetState();
}

class _SaleCategoryWidgetState extends State<SaleCategoryWidget> {
  final List<SaleCategoryModel> categories = const [
    SaleCategoryModel(
        parent: SelectOptionModel(label: "គ្រឿងក្លែម", value: 'vegetable'),
        children: [
          SaleCategoryModel(
              parent: SelectOptionModel(
                  label: "គ្រឿងសមុទ្រ", value: "salad", extra: "vegetable"),
              children: [
                SaleCategoryModel(
                    parent: SelectOptionModel(
                        label: "Salad A+", value: "salad-a+", extra: "salad"),
                    children: [
                      SaleCategoryModel(
                          parent: SelectOptionModel(
                              label: "Salad A++",
                              value: "Salad A++",
                              extra: "salad-a+"))
                    ]),
                SaleCategoryModel(
                  parent: SelectOptionModel(
                      label: "Salad B+", value: "salad-b+", extra: "salad"),
                )
              ]),
        ]),
    SaleCategoryModel(parent: SelectOptionModel(label: "Meat", value: "meat")),
    SaleCategoryModel(
        parent: SelectOptionModel(label: "Drink", value: "drink")),
  ];

  List<SaleCategoryModel> selectedCategory = [
    const SaleCategoryModel(
        parent: SelectOptionModel(label: "All", value: "all"))
  ];

  final ItemScrollController _breadcrumbScrollController =
      ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          // Breadcrumb
          if (selectedCategory.length > 1)
            SizedBox(
              height: 60.0,
              child: ScrollablePositionedList.builder(
                  scrollDirection: Axis.horizontal,
                  itemScrollController: _breadcrumbScrollController,
                  shrinkWrap: true,
                  itemCount: selectedCategory.length,
                  // padding: const EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    final SaleCategoryModel category = selectedCategory[index];
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedCategory.removeRange(
                                  index + 1, selectedCategory.length);
                            });

                            // auto scroll to index
                            _breadcrumbScrollController.scrollTo(
                                index: index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutCubic);
                          },
                          child: Text(category.parent.label),
                        ),
                        if (selectedCategory.length != index + 1)
                          const Icon(RestaurantDefaultIcons.next)
                      ],
                    );
                  }),
            ),
          if (selectedCategory.length > 1) const Divider(height: 0.0),
          if (selectedCategory.length == 1)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(RestaurantDefaultIcons.extraFoods),
                        label: Text(
                          'screens.sale.category.extraFoods',
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.canvasColor,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.all(8.0)),
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedCategory.length > 1
                  ? selectedCategory[selectedCategory.length - 1]
                      .children
                      .length
                  : categories.length,
              // padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final SaleCategoryModel category = selectedCategory.length > 1
                    ? selectedCategory[selectedCategory.length - 1]
                        .children[index]
                    : categories[index];
                return SaleCategoryItemWidget(
                  category: category,
                  onPressed: () async {
                    if (category.children.isNotEmpty) {
                      setState(() {
                        selectedCategory.add(category);
                      });
                    }

                    // auto scroll to last index
                    if (selectedCategory.length > 2) {
                      _breadcrumbScrollController.scrollTo(
                          index: selectedCategory.length,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCubic);
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
