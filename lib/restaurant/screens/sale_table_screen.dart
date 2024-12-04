import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../router/route_utils.dart';
import '../../utils/constants.dart';
import '../../widgets/no_internet_connection_widget.dart';
import '../models/sale-table/floor_model.dart';
import '../models/sale-table/table_model.dart';
import '../providers/sale-table/sale_table_provider.dart';
import '../widgets/department_widget.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/loading_widget.dart';
import '../widgets/sale-table/sale_table_app_bar_widget.dart';
import '../widgets/sale-table/sale_table_widget.dart';

class SaleTableScreen extends StatefulWidget {
  const SaleTableScreen({super.key});

  @override
  State<SaleTableScreen> createState() => _SaleTableScreenState();
}

class _SaleTableScreenState extends State<SaleTableScreen> {
  late AppProvider _readAppProvider;
  late SaleTableProvider _readSaleTableProvider;
  final _prefixSaleTableEmptyData = 'screens.saleTable.emptyData.description';

  @override
  void initState() {
    super.initState();
    _readAppProvider = context.read<AppProvider>();
    _readSaleTableProvider = context.read<SaleTableProvider>();
  }

  void setActiveFloor({required String floorId}) {
    final String branchId = _readAppProvider.selectedBranch!.id;
    final String depId = _readAppProvider.selectedDepartment!.id;
    final bool? displayTableAllDepartment =
        _readAppProvider.saleSetting.sale.displayTableAllDepartment;
    _readSaleTableProvider.setActiveFloor(
        floorId: floorId,
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);
  }

  @override
  void dispose() {
    super.dispose();
    _readSaleTableProvider.unSubscribe();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // subscribe sales
    _readSaleTableProvider.subscribeSales(context: context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: SaleTableAppBarWidget(title: SCREENS.saleTable.toTitle),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: AppStyleDefaultProperties.p,
                    right: AppStyleDefaultProperties.p),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [DepartmentWidget()],
                ),
              ),
              Expanded(
                child: Selector<
                    SaleTableProvider,
                    ({
                      bool isLoading,
                      List<FloorModel> floors,
                    })>(
                  selector: (context, state) => (
                    isLoading: state.isLoading,
                    floors: state.floors,
                  ),
                  builder: (context, data, child) {
                    final bool isScrollable =
                        data.floors.isNotEmpty && data.floors.length > 2
                            ? true
                            : false;
                    if (data.isLoading) {
                      return const LoadingWidget();
                    } else {
                      return data.floors.isNotEmpty
                          ? DefaultTabController(
                              length: data.floors.length,
                              child: Builder(builder: (context) {
                                final TabController controller =
                                    DefaultTabController.of(context);
                                controller.addListener(() {
                                  if (!controller.indexIsChanging) {
                                    setActiveFloor(
                                        floorId:
                                            data.floors[controller.index].id);
                                  }
                                });
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    TabBar(
                                      isScrollable: isScrollable,
                                      labelStyle: theme.textTheme.bodyLarge,
                                      tabs: data.floors.mapIndexed((e, i) {
                                        return Tab(
                                          text: e.id == 'All'
                                              ? e.name.tr()
                                              : e.name,
                                        );
                                      }).toList(),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children:
                                            data.floors.mapIndexed((e, i) {
                                          return Selector<
                                                  SaleTableProvider,
                                                  ({
                                                    List<TableModel> tables,
                                                    bool isFiltering
                                                  })>(
                                              selector: (context, state) => (
                                                    tables: state.tables,
                                                    isFiltering:
                                                        state.isFiltering
                                                  ),
                                              builder: (context, data, child) {
                                                return data.isFiltering
                                                    ? const LoadingWidget()
                                                    : data.tables.isEmpty
                                                        ? EmptyDataWidget(
                                                            description:
                                                                '$_prefixSaleTableEmptyData.table')
                                                        : SaleTableWidget(
                                                            tables:
                                                                data.tables);
                                              });
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            )
                          : EmptyDataWidget(
                              description: '$_prefixSaleTableEmptyData.floor');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Selector<AppProvider, bool>(
            selector: (_, state) => state.connected,
            builder: (context, connected, child) => !connected
                ? const NoInternetConnectionWidget()
                : const SizedBox.shrink()),
      ),
    );
  }
}
