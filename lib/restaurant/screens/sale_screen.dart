import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../providers/sale/categories/sale_categories_provider.dart';
import '../providers/sale/products/sale_products_provider.dart';
import '../providers/sale/sale_provider.dart';
import '../widgets/sale/app-bar/sale_app_bar_widget.dart';
import '../widgets/sale/category/sale_category_widget.dart';
import '../widgets/sale/detail/sale_detail_widget.dart';
import '../widgets/sale/product/sale_product_widget.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final PanelController _salePC = PanelController();
  late SaleProvider _readSaleProvider;
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  @override
  void initState() {
    super.initState();
    _readSaleProvider = context.read<SaleProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    // init sales,categories & products data
    _readSaleProvider.initData(context: context);
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
                  const SizedBox(
                      width: 200.0,
                      child: Padding(
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
          : const Row(children: [
              SizedBox(
                  width: 200.0,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: AppStyleDefaultProperties.p / 1.5,
                        left: AppStyleDefaultProperties.p),
                    child: SaleCategoryWidget(),
                  )),
              Expanded(child: SaleProductWidget()),
              Expanded(child: SaleDetailWidget()),
            ]),
      resizeToAvoidBottomInset: false,
    );

    const Scaffold desktopScaffold = Scaffold(
      appBar: SaleAppBarWidget(),
      body: Row(children: [
        SizedBox(
            width: 200.0,
            child: Padding(
              padding: EdgeInsets.only(
                  top: AppStyleDefaultProperties.p / 1.5,
                  left: AppStyleDefaultProperties.p),
              child: SaleCategoryWidget(),
            )),
        Expanded(flex: 3, child: SaleProductWidget()),
        Expanded(flex: 3, child: SaleDetailWidget()),
      ]),
      resizeToAvoidBottomInset: false,
    );
    return ResponsiveLayout(
      mobileScaffold: mobileScaffold,
      tabletScaffold: tabletScaffold,
      desktopScaffold: desktopScaffold,
    );
  }
}
