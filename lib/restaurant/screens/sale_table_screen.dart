import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../router/route_utils.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar_widget.dart';
import '../models/sale-table/floor_model.dart';
import '../models/sale-table/table_model.dart';
import '../providers/sale-table/sale_table_provider.dart';
import '../widgets/department_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/sale-table/sale_table_widget.dart';

class SaleTableScreen extends StatefulWidget {
  const SaleTableScreen({super.key});

  @override
  State<SaleTableScreen> createState() => _SaleTableScreenState();
}

class _SaleTableScreenState extends State<SaleTableScreen> {
  late AppProvider _readAppProvider;
  late SaleTableProvider _readSaleTableProvider;
  bool isScrollable = true;
  bool showNextIcon = true;
  bool showBackIcon = true;

  @override
  void initState() {
    super.initState();
    _readAppProvider = context.read<AppProvider>();
    _readSaleTableProvider = context.read<SaleTableProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _readSaleTableProvider.subscribeSales(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _readSaleTableProvider.unSubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: SCREENS.saleTable.toTitle),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(AppStyleDefaultProperties.p),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [DepartmentWidget()],
                ),
              ),
              Expanded(
                child: Selector<SaleTableProvider,
                    ({List<FloorModel> floors, List<TableModel> tables})>(
                  selector: (context, state) =>
                      (floors: state.floors, tables: state.tables),
                  builder: (context, data, child) {
                    return data.floors.isNotEmpty
                        ? DynamicTabBarWidget(
                            dynamicTabs: data.floors.mapIndexed((e, i) {
                              return TabData(
                                index: i,
                                title: Tab(
                                  child: Text(e.id == 'All'
                                      ? context.tr(e.name)
                                      : e.name),
                                ),
                                content: SaleTableWidget(tables: data.tables),
                              );
                            }).toList(),
                            isScrollable: isScrollable,
                            onTabControllerUpdated: (controller) {},
                            onTabChanged: (index) {
                              final String floorId = data.floors[index!].id;
                              final String branchId =
                                  _readAppProvider.selectedBranch!.id;
                              final String depId =
                                  _readAppProvider.selectedDepartment!.id;
                              final bool? displayTableAllDepartment =
                                  _readAppProvider.saleSetting.sale
                                      .displayTableAllDepartment;
                              context.read<SaleTableProvider>().setActiveFloor(
                                  floorId: floorId,
                                  branchId: branchId,
                                  depId: depId,
                                  displayTableAllDepartment:
                                      displayTableAllDepartment);
                            },
                            showBackIcon: showBackIcon,
                            showNextIcon: showNextIcon,
                          )
                        : const LoadingWidget();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
