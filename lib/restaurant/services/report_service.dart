import 'package:easy_localization/easy_localization.dart';
import '../../models/select-option/select_option_model.dart';
import '../../widgets/screens/app_screen.dart';

class ReportService {
  ReportService._();
  static const String _prefixSaleReportForm =
      'screens.reports.customer.children.sale.form';
  static const String _prefixSaleDetailReportForm =
      'screens.reports.customer.children.saleDetail.form';
  static const String _prefixSaleReceiptReportForm =
      'screens.reports.customer.children.saleReceipt.form';

  static final List<SelectOptionModel> _groupByOptions = [
    SelectOptionModel(
        label: '$_prefixSaleReportForm.groupBy.children.invoice'.tr(),
        value: 'refNo'),
    SelectOptionModel(
        label: '$_prefixSaleReportForm.groupBy.children.date'.tr(),
        value: 'date'),
    SelectOptionModel(
        label: '$_prefixSaleReportForm.groupBy.children.employee'.tr(),
        value: 'employee'),
  ];
  static List<SelectOptionModel> get groupByOptions => _groupByOptions;

  static final List<SelectOptionModel> _saleDetailGroupByOptions = [
    SelectOptionModel(
        label: '$_prefixSaleDetailReportForm.groupBy.children.item'.tr(),
        value: 'item'),
    SelectOptionModel(
        label: '$_prefixSaleDetailReportForm.groupBy.children.date'.tr(),
        value: 'date'),
    SelectOptionModel(
        label: '$_prefixSaleDetailReportForm.groupBy.children.employee'.tr(),
        value: 'employee'),
  ];
  static List<SelectOptionModel> get saleDetailGroupByOptions =>
      _saleDetailGroupByOptions;

  static final List<SelectOptionModel> _orderByOptions = [
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.date'.tr(),
        value: 'date'),
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.invoice'.tr(),
        value: 'refNo'),
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.department'.tr(),
        value: 'depName'),
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.customer'.tr(),
        value: 'guestName'),
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.employee'.tr(),
        value: 'employeeName'),
    SelectOptionModel(
        label: '$_prefixSaleReceiptReportForm.orderBy.children.status'.tr(),
        value: 'status'),
  ];
  static List<SelectOptionModel> get orderByOptions => _orderByOptions;

  static final List<SelectOptionModel> _statusOptions = [
    SelectOptionModel(
        label: '$_prefixSaleReportForm.status.children.open'.tr(),
        value: 'Open'),
    SelectOptionModel(
        label: '$_prefixSaleReportForm.status.children.partial'.tr(),
        value: 'Partial'),
    SelectOptionModel(
        label: '$_prefixSaleReportForm.status.children.closed'.tr(),
        value: 'Closed'),
    SelectOptionModel(
        label: '$_prefixSaleReportForm.status.children.cancel'.tr(),
        value: 'Cancel')
  ];

  static List<SelectOptionModel> get statusOptions => _statusOptions;

  static Future<List<SelectOptionModel>> getDepartments(
      {required String branchId,
      required List<String> allowDepartmentIds}) async {
    Map<String, dynamic> selector = {
      '_id': {'\$in': allowDepartmentIds},
      'branchId': branchId
    };
    List<dynamic> result = await meteor.call('rest.findDepartments', args: [
      {'selector': selector}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getCustomers(
      {required String branchId}) async {
    Map<String, dynamic> selector = {'branchId': branchId};
    List<dynamic> result = await meteor.call('rest.findGuests', args: [
      {'selector': selector}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getEmployees(
      {required String branchId}) async {
    Map<String, dynamic> selector = {
      'profile.branchPermissions': {
        '\$in': [branchId]
      },
      'username': {'\$ne': 'super'}
    };
    List<dynamic> result = await meteor.call('app.findUsers', args: [
      {'selector': selector}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['profile']['fullName'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getCategories(
      {required String branchId}) async {
    Map<String, dynamic> selector = {
      'branchId': branchId,
      'productType': {
        '\$in': ['Product', 'Dish', 'Service', 'ExtraFood']
      },
    };
    List<dynamic> result = await meteor.call('rest.lookupCategory', args: [
      {'selector': selector}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getProducts(
      {required String branchId, String search = ''}) async {
    Map<String, dynamic> selector = {
      'branchId': branchId,
      'type': ['Product', 'Dish', 'Catalog', 'Service', 'ExtraFood'],
      'search': search
    };
    List<dynamic> result =
        await meteor.call('rest.lookupProduct', args: [selector]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getGroups(
      {required String branchId}) async {
    Map<String, dynamic> selector = {
      'branchId': branchId,
    };
    List<dynamic> result = await meteor.call('rest.lookupGroup', args: [
      {'selector': selector}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  static Future<List<SelectOptionModel>> getPaymentMethods(
      {required String branchId}) async {
    Map<String, dynamic> selector = {'branchId': branchId};
    List<dynamic> result = await meteor.call('rest.findPaymentMethods', args: [
      {
        'selector': selector,
        'options': {
          'sort': {'name': 1}
        },
      }
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }
}
