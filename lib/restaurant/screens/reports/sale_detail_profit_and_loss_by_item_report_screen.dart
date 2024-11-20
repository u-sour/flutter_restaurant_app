import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../router/route_utils.dart';
import '../../../utils/alert/alert.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../../widgets/loading_widget.dart';
import '../../models/option/option_model.dart';
import '../../providers/report-template/report_template_provider.dart';
import '../../providers/reports/sale_detail_profit_and_loss_by_item_report_provider.dart';
import '../../widgets/report/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_content_widget.dart';
import '../../widgets/report/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_filter_widget.dart';
import '../../widgets/report/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_form_widget.dart';
import '../../widgets/report/report_app_bar_widget.dart';
import '../../widgets/report_template/report_template_content_widget.dart';
import '../../widgets/report_template/report_template_footer_widget.dart';
import '../../widgets/report_template/report_template_header_widget.dart';
import '../../widgets/report_template/report_template_signature_widget.dart';
import '../../widgets/report_template/report_template_timestamp_widget.dart';
import '../report_template_screen.dart';

class SaleDetailProfitAndLossByItemReportScreen extends StatefulWidget {
  const SaleDetailProfitAndLossByItemReportScreen({super.key});

  @override
  State<SaleDetailProfitAndLossByItemReportScreen> createState() =>
      _SaleDetailProfitAndLossByItemReportScreenState();
}

class _SaleDetailProfitAndLossByItemReportScreenState
    extends State<SaleDetailProfitAndLossByItemReportScreen> {
  late ReportTemplateProvider readReportTemplateProvider;
  late SaleDetailProfitAndLossByItemReportProvider
      readSaleDetailProfitAndLossByItemReportProvider;
  static final GlobalKey<FormBuilderState>
      _fbSaleDetailProfitAndLossByItemReportKey = GlobalKey<FormBuilderState>();
  late Future<List<OptionModel>> filters;
  @override
  void initState() {
    super.initState();
    readReportTemplateProvider = context.read<ReportTemplateProvider>();
    readSaleDetailProfitAndLossByItemReportProvider =
        context.read<SaleDetailProfitAndLossByItemReportProvider>();
    readSaleDetailProfitAndLossByItemReportProvider.initData();
    filters = readSaleDetailProfitAndLossByItemReportProvider.initFilters(
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReportAppBarWidget(
          title: SCREENS.profitAndLossByItemReport.toReportTitle,
          onPressed: () async {
            if (_fbSaleDetailProfitAndLossByItemReportKey.currentState!
                .saveAndValidate()) {
              // form doc
              Map<String, dynamic> formDoc = Map.of(
                  _fbSaleDetailProfitAndLossByItemReportKey
                      .currentState!.value);
              // prepare data
              DateTimeRange date = formDoc['reportPeriod'];
              DateTime startOfDay = date.start.startOfDay;
              DateTime endOfDay = date.end.endOfDay;
              formDoc['reportPeriod'] = [startOfDay, endOfDay];
              formDoc['branchId'] =
                  readSaleDetailProfitAndLossByItemReportProvider.branchId;
              // submit
              readReportTemplateProvider.setIsFiltering(isFiltering: true);
              ResponseModel? result =
                  await readSaleDetailProfitAndLossByItemReportProvider.submit(
                      formDoc: formDoc);
              readReportTemplateProvider.setIsFiltering(isFiltering: false);
              if (result != null) {
                // show alert
                if (result.type == AWESOMESNACKBARTYPE.failure) {
                  late SnackBar snackBar;
                  snackBar = Alert.awesomeSnackBar(
                      message: result.message, type: result.type);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              }
            }
          },
        ),
        body: FutureBuilder(
            future: filters,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                List<OptionModel> filters = snapshot.data!;
                return ReportTemplateScreen(
                  form: SaleDetailProfitAndLossByItemReportFormWidget(
                    fbKey: _fbSaleDetailProfitAndLossByItemReportKey,
                  ),
                  reportTemplateLayouts: [
                    ReportTemplateHeaderWidget(
                        reportTitle:
                            SCREENS.profitAndLossByItemReport.toReportTitle),
                    SaleDetailProfitAndLossByItemReportFilterWidget(
                        filters: filters),
                    const ReportTemplateContentWidget(
                        reportContent:
                            SaleDetailProfitAndLossByItemReportContentWidget()),
                    const ReportTemplateTimestampWidget(),
                    const ReportTemplateFooterWidget(),
                    const ReportTemplateSignatureWidget(),
                  ],
                );
              } else {
                return const LoadingWidget();
              }
            }));
  }
}
