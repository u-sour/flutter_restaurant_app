import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../providers/app_provider.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../widgets/no_internet_connection_widget.dart';
import '../providers/sale/categories/sale_categories_provider.dart';
import '../providers/sale/products/sale_products_provider.dart';
import '../providers/sale/sale_provider.dart';
import '../widgets/sale/app-bar/sale_app_bar_widget.dart';
import '../widgets/sale/category/sale_category_widget.dart';
import '../widgets/sale/detail/sale_detail_widget.dart';
import '../widgets/sale/product/sale_product_widget.dart';

class SaleScreen extends StatefulWidget {
  final String? id;
  final String table;
  final bool fastSale;
  const SaleScreen(
      {super.key, this.id, required this.table, required this.fastSale});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final PanelController _salePC = PanelController();
  late SaleProvider _readSaleProvider;
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  final double categoryWidgetWidth = 215.0;
  @override
  void initState() {
    super.initState();
    _readSaleProvider = context.read<SaleProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    // init sales,categories & products data
    _readSaleProvider.initData(
      invoiceId: widget.id,
      table: widget.table,
      fastSale: widget.fastSale,
      context: context,
    );
    _readSaleCategoriesProvider.initData(context: context);
    _readSaleProductsProvider.initData(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _readSaleProvider.removeEmptySaleInvoiceMethod();
    _readSaleProvider.unSubscribe();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Orientation orientation = MediaQuery.orientationOf(context);
    double minHeight = 65.0;
    double maxHeight = MediaQuery.sizeOf(context).height * 0.8;
    if (ResponsiveLayout.isMobile(context)) {
      maxHeight = MediaQuery.sizeOf(context).height * 0.7;
    }

    Scaffold mobileScaffold = Scaffold(
      appBar: const SaleAppBarWidget(),
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.all(AppStyleDefaultProperties.p),
          child: SaleCategoryWidget(),
        ),
      ),
      body:
          // orientation == Orientation.portrait
          //     ?
          SlidingUpPanel(
        color: theme.scaffoldBackgroundColor,
        controller: _salePC,
        minHeight: minHeight,
        maxHeight: maxHeight,
        backdropEnabled: true,
        panel: SaleDetailWidget(
          enableSaleAppBarActionWidget: true,
          onTap: () {
            _salePC.isPanelOpen ? _salePC.close() : _salePC.open();
          },
        ),
        body: SaleProductWidget(
            slidingUpPanelMinHeight: minHeight +
                AppBar().preferredSize.height +
                AppStyleDefaultProperties.p / 1.5),
      ),
      // : const Row(
      //     children: [
      //       Expanded(child: SaleProductWidget()),
      //       Expanded(child: SaleDetailWidget()),
      //     ],
      //   ),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
      resizeToAvoidBottomInset: false,
    );

    Scaffold tabletScaffold = Scaffold(
      appBar: const SaleAppBarWidget(),
      body: orientation == Orientation.portrait
          ? SlidingUpPanel(
              color: theme.scaffoldBackgroundColor,
              controller: _salePC,
              minHeight: minHeight,
              maxHeight: maxHeight,
              backdropEnabled: true,
              panel: SaleDetailWidget(
                enableSaleAppBarActionWidget: true,
                onTap: () {
                  _salePC.isPanelOpen ? _salePC.close() : _salePC.open();
                },
              ),
              body: Row(
                children: [
                  SizedBox(
                      width: categoryWidgetWidth,
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: AppStyleDefaultProperties.p / 1.5,
                            left: AppStyleDefaultProperties.p),
                        child: SaleCategoryWidget(),
                      )),
                  Expanded(
                    child: SaleProductWidget(
                        slidingUpPanelMinHeight: minHeight +
                            AppBar().preferredSize.height +
                            AppStyleDefaultProperties.p / 1.5),
                  ),
                ],
              ),
            )
          : Row(children: [
              SizedBox(
                  width: categoryWidgetWidth,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: AppStyleDefaultProperties.p / 1.5,
                        left: AppStyleDefaultProperties.p),
                    child: SaleCategoryWidget(),
                  )),
              const Expanded(child: SaleProductWidget()),
              const Expanded(child: SaleDetailWidget()),
            ]),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
      resizeToAvoidBottomInset: false,
    );

    Scaffold desktopScaffold = Scaffold(
      appBar: const SaleAppBarWidget(),
      body: Row(children: [
        SizedBox(
            width: categoryWidgetWidth,
            child: const Padding(
              padding: EdgeInsets.only(
                  top: AppStyleDefaultProperties.p / 1.5,
                  left: AppStyleDefaultProperties.p),
              child: SaleCategoryWidget(),
            )),
        const Expanded(flex: 3, child: SaleProductWidget()),
        const Expanded(flex: 3, child: SaleDetailWidget()),
      ]),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
      resizeToAvoidBottomInset: false,
    );
    return ResponsiveLayout(
      mobileScaffold: mobileScaffold,
      tabletScaffold: tabletScaffold,
      desktopScaffold: desktopScaffold,
    );
  }
}
