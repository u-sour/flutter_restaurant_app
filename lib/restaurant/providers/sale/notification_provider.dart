import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../models/notification/notification_data_model.dart';
import '../../models/notification/notification_model.dart';
import '../../models/user/user_profile_model.dart';
import '../../services/sale_service.dart';
import '../../services/user_service.dart';
import '../../utils/debounce.dart';
import '../../utils/notification/notification_utils.dart';
import 'sale_provider.dart';

class NotificationProvider extends ChangeNotifier {
  late SubscriptionHandler _notificationSubscription;
  SubscriptionHandler get notificationSubscription => _notificationSubscription;
  late StreamSubscription<Map<String, dynamic>> _notificationListener;
  late String _branchId;
  late List<String> _allowDepIds;
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  late List<String> _allowNotificationTypes;
  List<String> get allowNotificationTypes => _allowNotificationTypes;
  late String _notificationType;
  String get notificationType => _notificationType;
  NotificationModel _notifications =
      const NotificationModel(data: [], totalCount: 0);
  NotificationModel get notifications => _notifications;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;

  void initData({required BuildContext context}) {
    AppProvider readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _allowDepIds = [];
    UserProfileModel? profile = readAppProvider.currentUser?.profile;
    if (profile != null && profile.depIds.isNotEmpty) {
      _allowDepIds = profile.depIds;
    }
    _notificationType = NotificationType.invoice.toValue;
    _allowNotificationTypes = getAllowNotificationTypes(context: context);
    subscribeNotifications();
    notifyListeners();
  }

  void subscribeNotifications() {
    final debounce = Debounce(delay: const Duration(milliseconds: 800));
    Map<String, dynamic> selector = {'branchId': _branchId};
    Map<String, dynamic> option = {
      'sort': {'date': -1},
      'limit': 10
    };
    _notificationSubscription = meteor
        .subscribe('notifications', args: [selector, option], onReady: () {
      _isLoading = true;
      notifyListeners();
      _notificationListener = _notificationListener =
          meteor.collection('rest_notifications').listen((event) {
        debounce.run(() async {
          _notifications = await fetchNotification(
              notificationType: _notificationType,
              allowNotificationTypes: _allowNotificationTypes,
              depIds: _allowDepIds,
              branchId: _branchId);
          _isLoading = false;
          notifyListeners();
        });
      });
    });
  }

  List<String> getAllowNotificationTypes({required BuildContext context}) {
    List<String> allowNotificationTypes = [];
    if (SaleService.isModuleActive(
            modules: ['tablet-orders'], overpower: false, context: context) &&
        UserService.userInRole(roles: ['cashier'], overpower: false)) {
      allowNotificationTypes.add(NotificationType.invoice.toValue);
    }
    if (SaleService.isModuleActive(
        modules: ['chef-monitor'], overpower: false, context: context)) {
      allowNotificationTypes.add(NotificationType.chefMonitor.toValue);
    }
    if (SaleService.isModuleActive(
        modules: ['purchase'], overpower: false, context: context)) {
      allowNotificationTypes.add(NotificationType.stockAlert.toValue);
    }
    return allowNotificationTypes;
  }

  Future<void> filter({int tab = 0, required String notificationType}) async {
    _isFiltering = true;
    notifyListeners();
    _selectedTab = tab;
    _notificationType = notificationType;
    _notifications = await fetchNotification(
        notificationType: _notificationType,
        allowNotificationTypes: _allowNotificationTypes,
        depIds: _allowDepIds,
        branchId: _branchId);
    _isFiltering = false;
    notifyListeners();
  }

  Future<ResponseModel?> removeNotificationById({required String id}) async {
    ResponseModel? result;
    try {
      await removeNotificationByIdMethod(id: id);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  Future<ResponseModel?> removeAllNotification(
      {required List<String> notificationTypes,
      required String branchId}) async {
    ResponseModel? result;
    try {
      await removeAllNotificationMethod(
          notificationTypes: notificationTypes, branchId: branchId);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  Future<ResponseModel?> enterSale(
      {required NotificationDataModel notification,
      required BuildContext context}) async {
    ResponseModel? result;
    try {
      await markReadNotificationMethod(id: notification.id);
      if (context.mounted) {
        context.read<SaleProvider>().handleEnterSale(
            context: context,
            tableId: notification.tableId,
            invoiceId: notification.refId!);
      }
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  Future<NotificationModel> fetchNotification(
      {required String notificationType,
      required List<String> allowNotificationTypes,
      required List<String> depIds,
      required String branchId}) async {
    Map<String, dynamic> selector = {
      'type': notificationType,
      'allowTypes': allowNotificationTypes,
      'depIds': depIds,
      'branchId': branchId,
      'currentDate': DateTime.now(),
    };
    final Map<String, dynamic> result =
        await meteor.call('rest.mobile.findNotifications', args: [selector]);
    late NotificationModel toModel;
    if (result.isNotEmpty) {
      toModel = NotificationModel.fromJson(result);
    }
    return toModel;
  }

  Future<dynamic> markReadNotificationMethod({required String id}) {
    return meteor.call('rest.markReadNotification', args: [
      {'_id': id}
    ]);
  }

  Future<dynamic> removeNotificationByIdMethod({required String id}) {
    return meteor.call('rest.removeNotisById', args: [
      {'_id': id}
    ]);
  }

  Future<dynamic> removeAllNotificationMethod(
      {required List<String> notificationTypes, required String branchId}) {
    return meteor.call('rest.removeAllNotis', args: [
      {'types': notificationTypes, 'branchId': branchId}
    ]);
  }

  void unSubscribe() {
    if (_notificationSubscription.subId.isNotEmpty) {
      _notificationSubscription.stop();
      _notificationListener.cancel();
    }
  }
}
