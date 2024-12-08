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
import '../../providers/reports/sale_detail_report_provider.dart';
import '../../widgets/report/report_app_bar_widget.dart';
import '../../widgets/report/sale-detail/sale_detail_report_content_widget.dart';
import '../../widgets/report/sale-detail/sale_detail_report_filter_widget.dart';
import '../../widgets/report/sale-detail/sale_detail_report_form_widget.dart';
import '../../widgets/report_template/report_template_content_widget.dart';
import '../../widgets/report_template/report_template_footer_widget.dart';
import '../../widgets/report_template/report_template_header_widget.dart';
import '../../widgets/report_template/report_template_signature_widget.dart';
import '../../widgets/report_template/report_template_timestamp_widget.dart';
import '../report_template_screen.dart';

class SaleDetailReportScreen extends StatefulWidget {
  const SaleDetailReportScreen({super.key});

  @override
  State<SaleDetailReportScreen> createState() => _SaleDetailReportScreenState();
}

class _SaleDetailReportScreenState extends State<SaleDetailReportScreen> {
  late ReportTemplateProvider readReportTemplateProvider;
  late SaleDetailReportProvider readSaleDetailReportProvider;
  static final GlobalKey<FormBuilderState> _fbSaleDetailReportKey =
      GlobalKey<FormBuilderState>();
  late Future<List<OptionModel>> filters;

  @override
  void initState() {
    super.initState();
    readReportTemplateProvider = context.read<ReportTemplateProvider>();
    readSaleDetailReportProvider = context.read<SaleDetailReportProvider>();
    readSaleDetailReportProvider.initData();
    filters = readSaleDetailReportProvider.initFilters(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBarWidget(
        title: SCREENS.saleDetailReport.toReportTitle,
        onPressed: () async {
          if (_fbSaleDetailReportKey.currentState!.saveAndValidate()) {
            // form doc
            Map<String, dynamic> formDoc =
                Map.of(_fbSaleDetailReportKey.currentState!.value);
            // prepare data
            DateTimeRange date = formDoc['reportPeriod'];
            DateTime startOfDay = date.start.startOfDay;
            DateTime endOfDay = date.end.endOfDay;
            formDoc['reportPeriod'] = [startOfDay, endOfDay];
            formDoc['branchId'] = readSaleDetailReportProvider.branchId;
            // submit
            readReportTemplateProvider.setIsFiltering(isFiltering: true);
            ResponseModel? result =
                await readSaleDetailReportProvider.submit(formDoc: formDoc);
            readReportTemplateProvider.setIsFiltering(isFiltering: false);
            // close form
            readReportTemplateProvider.expansionTileController.collapse();
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
                form: SaleDetailReportFormWidget(
                  fbKey: _fbSaleDetailReportKey,
                ),
                reportTemplateLayouts: [
                  ReportTemplateHeaderWidget(
                      reportTitle: SCREENS.saleDetailReport.toReportTitle),
                  SaleDetailReportFilterWidget(filters: filters),
                  const ReportTemplateContentWidget(
                      reportContent: SaleDetailReportContentWidget()),
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
