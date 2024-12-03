import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../models/invoice-template/invoice_template_model.dart';

class InvoiceTemplateProvider extends ChangeNotifier {
  Future<InvoiceTemplateModel> getInvoiceTemplate(
      {required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    String branchId = readAppProvider.selectedBranch!.id;
    final Map<String, dynamic> result =
        await findOneInvoiceTemplateMethod(branchId: branchId);
    InvoiceTemplateModel toModel = InvoiceTemplateModel.fromJson(result);
    return toModel;
  }

  Future<dynamic> findOneInvoiceTemplateMethod({required String branchId}) {
    Map<String, dynamic> selector = {'branchId': branchId};
    return meteor.call('rest.findOneInvoiceTemplate', args: [
      {'selector': selector}
    ]);
  }
}
