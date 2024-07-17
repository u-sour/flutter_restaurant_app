import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
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
    double minHeight = 65.0;
    double maxHeight = MediaQuery.sizeOf(context).height * 0.8;
    if (ResponsiveLayout.isMobile(context)) {
      maxHeight = MediaQuery.sizeOf(context).height * 0.7;
    }
    Scaffold mobileAndTabletScaffold = Scaffold(
      appBar: const SaleAppBarWidget(title: ""),
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.all(AppStyleDefaultProperties.p),
          child: SaleCategoryWidget(),
        ),
      ),
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
              body: SaleProductWidget(
                  slidingUpPanelMinHeight: minHeight +
                      AppBar().preferredSize.height +
                      AppStyleDefaultProperties.p / 1.5),
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
        SizedBox(
            width: 200.0,
            child: Padding(
              padding: EdgeInsets.only(
                  top: AppStyleDefaultProperties.p,
                  left: AppStyleDefaultProperties.p),
              child: SaleCategoryWidget(),
            )),
        Expanded(flex: 3, child: SaleProductWidget()),
        Expanded(flex: 3, child: SaleDetailWidget()),
      ]),
      resizeToAvoidBottomInset: false,
    );
    return ResponsiveLayout(
      mobileScaffold: mobileAndTabletScaffold,
      tabletScaffold: mobileAndTabletScaffold,
      desktopScaffold: desktopScaffold,
    );
  }
}
