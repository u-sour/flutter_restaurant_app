import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../providers/sale/products/sale_products_provider.dart';
import '../utils/constants.dart';

class SearchWidget extends StatefulWidget {
  final IconData prefixIcon;
  final void Function(String?)? onChanged;
  const SearchWidget(
      {super.key,
      this.prefixIcon = RestaurantDefaultIcons.search,
      this.onChanged});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SaleProductsProvider _readSaleProductsProvider;
  @override
  void initState() {
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    _readSaleProductsProvider.fbSearchKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _readSaleProductsProvider.fbSearchKey,
      child: FormBuilderTextField(
        name: 'search',
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixIcon),
            hintText: 'screens.sale.search'.tr(),
            isDense: true),
        onChanged: widget.onChanged,
      ),
    );
  }
}
