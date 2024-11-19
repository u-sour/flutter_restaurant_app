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
import '../../providers/reports/sale_report_provider.dart';
import '../../utils/report/sale_report_utils.dart';
import '../../widgets/report/report_app_bar_widget.dart';
import '../../widgets/report/sale/sale_report_content_widget.dart';
import '../../widgets/report/sale/sale_report_form_widget.dart';
import '../../widgets/report/sale/sale_report_summary_content_widget.dart';
import '../../widgets/report_template/report_template_content_widget.dart';
import '../../widgets/report/sale/sale_report_filter_widget.dart';
import '../../widgets/report_template/report_template_footer_widget.dart';
import '../../widgets/report_template/report_template_header_widget.dart';
import '../../widgets/report_template/report_template_signature_widget.dart';
import '../../widgets/report_template/report_template_timestamp_widget.dart';
import '../report_template_screen.dart';

class SaleReportScreen extends StatefulWidget {
  const SaleReportScreen({super.key});

  @override
  State<SaleReportScreen> createState() => _SaleReportScreenState();
}

class _SaleReportScreenState extends State<SaleReportScreen> {
  late ReportTemplateProvider readReportTemplateProvider;
  late SaleReportProvider readSaleReportProvider;
  static final GlobalKey<FormBuilderState> _fbSaleReportKey =
      GlobalKey<FormBuilderState>();
  late Future<List<OptionModel>> filters;

  @override
  void initState() {
    super.initState();
    readReportTemplateProvider = context.read<ReportTemplateProvider>();
    readSaleReportProvider = context.read<SaleReportProvider>();
    readSaleReportProvider.initData();
    filters = readSaleReportProvider.initFilters(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBarWidget(
        title: SCREENS.saleReport.toReportTitle,
        onPressed: () async {
          if (_fbSaleReportKey.currentState!.saveAndValidate()) {
            // form doc
            Map<String, dynamic> formDoc =
                Map.of(_fbSaleReportKey.currentState!.value);
            // prepare data
            DateTimeRange date = formDoc['reportPeriod'];
            DateTime startOfDay = date.start.startOfDay;
            DateTime endOfDay = date.end.endOfDay;
            formDoc['reportPeriod'] = [startOfDay, endOfDay];
            formDoc['branchId'] = readSaleReportProvider.branchId;
            // isSummary == true then remove status and groupBy
            if (formDoc['isSummary']) {
              formDoc.removeWhere(
                  (key, value) => key == 'status' || key == 'groupBy');
            }
            // submit
            readReportTemplateProvider.setIsFiltering(isFiltering: true);
            ResponseModel? result =
                await readSaleReportProvider.submit(formDoc: formDoc);
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
              return ReportTemplateScreen(
                form: SaleReportFormWidget(fbKey: _fbSaleReportKey),
                reportTemplateLayouts: [
                  ReportTemplateHeaderWidget(
                      reportTitle: SCREENS.saleReport.toReportTitle),
                  Selector<SaleReportProvider, bool>(
                      selector: (context, state) => state.isSummary,
                      builder: (context, isSummary, child) {
                        List<OptionModel> filters = isSummary
                            ? snapshot.data!
                                .where((f) =>
                                    f.label == SaleReportFilterType.customers.toTitle ||
                                    f.label ==
                                        SaleReportFilterType
                                            .employees.toTitle ||
                                    f.label ==
                                        SaleReportFilterType
                                            .departments.toTitle)
                                .toList()
                            : snapshot.data!;
                        return SaleReportFilterWidget(filters: filters);
                      }),
                  ReportTemplateContentWidget(
                      reportContent: Selector<SaleReportProvider, bool>(
                          selector: (context, state) => state.isSummary,
                          builder: (context, isSummary, child) {
                            return isSummary
                                ? const SaleReportSummaryContentWidget()
                                : const SaleReportContentWidget();
                          })),
                  const ReportTemplateTimestampWidget(),
                  const ReportTemplateFooterWidget(),
                  const ReportTemplateSignatureWidget(),
                ],
              );
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
