import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../../models/servers/response_model.dart';
import '../../../router/route_utils.dart';
import '../../../utils/alert/alert.dart';
import '../../../widgets/loading_widget.dart';
import '../../models/option/option_model.dart';
import '../../providers/report-template/report_template_provider.dart';
import '../../providers/reports/sale_receipt_report_provider.dart';
import '../../widgets/report/report_app_bar_widget.dart';
import '../../widgets/report/sale-receipt/sale_receipt_report_content_widget.dart';
import '../../widgets/report/sale-receipt/sale_receipt_report_filter_widget.dart';
import '../../widgets/report/sale-receipt/sale_receipt_report_form_widget.dart';
import '../../widgets/report_template/report_template_content_widget.dart';
import '../../widgets/report_template/report_template_footer_widget.dart';
import '../../widgets/report_template/report_template_header_widget.dart';
import '../../widgets/report_template/report_template_signature_widget.dart';
import '../../widgets/report_template/report_template_timestamp_widget.dart';
import '../report_template_screen.dart';

class SaleReceiptReportScreen extends StatefulWidget {
  const SaleReceiptReportScreen({super.key});

  @override
  State<SaleReceiptReportScreen> createState() =>
      _SaleReceiptReportScreenState();
}

class _SaleReceiptReportScreenState extends State<SaleReceiptReportScreen> {
  late ReportTemplateProvider readReportTemplateProvider;
  late SaleReceiptReportProvider readSaleReceiptReportProvider;
  static final GlobalKey<FormBuilderState> _fbSaleReceiptReportKey =
      GlobalKey<FormBuilderState>();
  late Future<List<OptionModel>> filters;

  @override
  void initState() {
    super.initState();
    readReportTemplateProvider = context.read<ReportTemplateProvider>();
    readSaleReceiptReportProvider = context.read<SaleReceiptReportProvider>();
    readSaleReceiptReportProvider.initData();
    filters = readSaleReceiptReportProvider.initFilters(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReportAppBarWidget(
          title: SCREENS.saleReceiptReport.toReportTitle,
          onPressed: () async {
            if (_fbSaleReceiptReportKey.currentState!.saveAndValidate()) {
              // form doc
              Map<String, dynamic> formDoc =
                  Map.of(_fbSaleReceiptReportKey.currentState!.value);
              // prepare data
              DateTime startOfDay = formDoc['startDate'];
              DateTime endOfDay = formDoc['endDate'];
              formDoc['reportPeriod'] = [startOfDay, endOfDay];
              // remove startDate and endDate
              formDoc.removeWhere(
                  (key, value) => key == 'startDate' || key == 'endDate');
              formDoc['branchId'] = readSaleReceiptReportProvider.branchId;
              // submit
              readReportTemplateProvider.setIsFiltering(isFiltering: true);
              ResponseModel? result =
                  await readSaleReceiptReportProvider.submit(formDoc: formDoc);
              readReportTemplateProvider.setIsFiltering(isFiltering: false);
              // close form
              readReportTemplateProvider.expansionTileController.collapse();
              if (result != null) {
                // show alert
                if (result.type == ToastificationType.error) {
                  Alert.show(
                      description: result.description, type: result.type);
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
                  form: SaleReceiptReportFormWidget(
                      fbKey: _fbSaleReceiptReportKey),
                  reportTemplateLayouts: [
                    ReportTemplateHeaderWidget(
                        reportTitle: SCREENS.saleReceiptReport.toReportTitle),
                    SaleReceiptReportFilterWidget(filters: filters),
                    const ReportTemplateContentWidget(
                        reportContent: SaleReceiptReportContentWidget()),
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
