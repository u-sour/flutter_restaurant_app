import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/providers/sale/sale_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../widgets/sale/app-bar/sale_app_bar_widget.dart';
import '../widgets/sale/category/sale_category_widget.dart';
import '../widgets/sale/detail/sale_detail_widget.dart';
import '../widgets/sale/product/sale_product_widget.dart';

class CreateSaleScreen extends StatefulWidget {
  const CreateSaleScreen({super.key});

  @override
  State<CreateSaleScreen> createState() => _CreateSaleScreenState();
}

class _CreateSaleScreenState extends State<CreateSaleScreen> {
  final PanelController _salePC = PanelController();
  late SaleProvider readProvider =
      Provider.of<SaleProvider>(context, listen: false);
  @override
  void initState() {
    super.initState();
    readProvider.initData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Orientation orientation = MediaQuery.orientationOf(context);
    Scaffold mobileAndTabletScaffold = Scaffold(
      appBar: const SaleAppBarWidget(title: ""),
      drawer: const Drawer(
        child: SaleCategoryWidget(),
      ),
      body: orientation == Orientation.portrait
          ? SlidingUpPanel(
              color: theme.scaffoldBackgroundColor,
              controller: _salePC,
              minHeight: 65.0,
              maxHeight: ResponsiveLayout.isMobile(context) ? 750.0 : 850.0,
              backdropEnabled: true,
              panel: SaleDetailWidget(
                enableSaleAppBarActionWidget: true,
                onTap: () {
                  _salePC.isPanelOpen ? _salePC.close() : _salePC.open();
                },
              ),
              body: const SaleProductWidget(),
            )
          : const Row(
              children: [
                Expanded(child: SaleProductWidget()),
                Expanded(child: SaleDetailWidget()),
              ],
            ),
      resizeToAvoidBottomInset: false,
    );
    const Scaffold desktopScaffold = Scaffold(
      appBar: SaleAppBarWidget(title: ""),
      body: Row(children: [
        Expanded(child: SaleCategoryWidget()),
        Expanded(flex: 2, child: SaleProductWidget()),
        Expanded(flex: 2, child: SaleDetailWidget()),
      ]),
      resizeToAvoidBottomInset: false,
    );
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        //clear all field focus
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ResponsiveLayout(
        mobileScaffold: mobileAndTabletScaffold,
        tabletScaffold: mobileAndTabletScaffold,
        desktopScaffold: desktopScaffold,
      ),
    );
  }
}
