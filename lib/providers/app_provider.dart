import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../restaurant/models/branch/branch_model.dart';
import '../restaurant/models/company/company_accounting_model.dart';
import '../restaurant/models/company/company_model.dart';
import '../restaurant/models/department/department_model.dart';
import '../restaurant/models/sale/setting/sale_setting_model.dart';
import '../restaurant/models/user/user_model.dart';
import '../restaurant/services/user_service.dart';
import '../restaurant/utils/debounce.dart';
import '../screens/app_screen.dart';
import '../storages/auth_storage.dart';

// ignore: non_constant_identifier_names
String ONBOARD_KEY = "GD2G82CG9G82VDFGVD22DVG";

class AppProvider extends ChangeNotifier {
  // Allowed Modules
  List<String> _allowModules = [];
  List<String> get allowModules => _allowModules;

  // Current User
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Company Subscription
  late SubscriptionHandler _subCompanyHandler;
  SubscriptionHandler get subCompanyHandler => _subCompanyHandler;
  late List<CompanyModel> _company;
  List<CompanyModel> get company => _company;
  late CompanyAccountingModel _companyAccounting;
  CompanyAccountingModel get companyAccounting => _companyAccounting;

  // Sale Settings Subscription
  SubscriptionHandler? _subSaleSettingsHandler;
  SubscriptionHandler? get subSaleSettingsHandler => _subSaleSettingsHandler;
  late SaleSettingModel _saleSetting;
  SaleSettingModel get saleSetting => _saleSetting;

  // Branch Subscription
  late SubscriptionHandler? _subBranchHandler;
  SubscriptionHandler? get subBranchHandler => _subBranchHandler;
  List<BranchModel> _branches = [];
  List<BranchModel> get branches => _branches;
  BranchModel? _selectedBranch;
  BranchModel? get selectedBranch => _selectedBranch;

  // Department Subscription
  late SubscriptionHandler? _subDepartmentHandler;
  SubscriptionHandler? get subDepartmentHandler => _subDepartmentHandler;
  List<DepartmentModel> _departments = [];
  List<DepartmentModel> get departments => _departments;
  DepartmentModel? _selectedDepartment;
  DepartmentModel? get selectedDepartment => _selectedDepartment;

  late final SharedPreferences sharedPreferences;
  // final StreamController<bool> _loginStateChange =
  //     StreamController<bool>.broadcast();
  bool _connected = false;
  bool _loginState = false;
  bool _initialized = false;
  bool _onboarding = false;
  AppProvider(this.sharedPreferences);

  //getter
  // Stream<bool> get loginStateChange => _loginStateChange.stream;
  bool get connected => _connected;
  bool get loginState => _loginState;
  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

  //setter
  set loginState(bool state) {
    _loginState = state;
    // _loginStateChange.add(state);
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(ONBOARD_KEY, value);
    _onboarding = value;
    notifyListeners();
  }

  //methods
  Future<void> onAppInit() async {
    _onboarding = sharedPreferences.getBool(ONBOARD_KEY) ?? false;
    // This is just to demonstrate the splash screen is working.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    await Future.delayed(const Duration(seconds: 1));
    _initialized = true;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    // Keep listening to server connection
    meteor.status().listen((onData) {
      _connected = onData.connected;
      if (_connected) {
        meteor.user().listen((currentUserDoc) {
          _loginState = currentUserDoc != null ? true : false;
          if (currentUserDoc != null) {
            // convert from map to user model
            _currentUser = UserModel.fromJson(currentUserDoc);
            startSubscribeModule();
            startSubscribeBranch(currentUser!);
            startSubscribeSaleSettings();
            startSubscribeDepartment();
            notifyListeners();
          }
        });
      }
      notifyListeners();
    });

    // Auto login if login token exist
    AuthStorage authStorage = AuthStorage();
    final loginTokenResult = await authStorage.getLoginToken();
    if (loginTokenResult['loginToken'] != null) {
      try {
        final result = await meteor.loginWithToken(
            token: loginTokenResult['loginToken'],
            tokenExpires: loginTokenResult['loginTokenExpires']);
        if (result != null && result.userId.isNotEmpty) {
          _loginState = true;
          authStorage.setLoginToken(loginResult: result);
          notifyListeners();
        }
      } catch (e) {
        if (e is MeteorError) {
          // print(e.message);
        }
      }
    }

    // Keep listening to company collection from server
    _subCompanyHandler = meteor.subscribe('app.company', onReady: () {
      meteor.collection('company').listen((result) {
        if (result.isNotEmpty) {
          List<CompanyModel> toListModel = result.values
              .toList()
              .map((e) => CompanyModel.fromJson(e))
              .toList();
          _company = toListModel;
          _companyAccounting = toListModel.first.accounting;
        }
        notifyListeners();
      });
    });
  }

  void startSubscribeModule() {
    // Keep listening to sale setting collection from server
    final debounce = Debounce(delay: const Duration(milliseconds: 500));
    _subSaleSettingsHandler =
        meteor.subscribe('app.module', args: [], onReady: () {
      meteor.collection('app_modules').listen((result) {
        //  call method only 1 time when module data updated
        debounce.run(() {
          //   getAllowModules();
          _allowModules =
              result.values.toList().map((e) => e['name'].toString()).toList();
          notifyListeners();
        });
      });
    });
  }

  // void getAllowModules() async {
  //   Map<String, dynamic> selector = {'active': true};
  //   List<dynamic> result = await meteor.call('app.findModules', args: [
  //     {'selector': selector}
  //   ]);
  //   // loop and get only field name
  //   _allowModules = result.map((e) => e['name'].toString()).toList();
  //   notifyListeners();
  // }

  void startSubscribeSaleSettings() {
    // Keep listening to sale setting collection from server
    final debounce = Debounce(delay: const Duration(milliseconds: 500));
    _subSaleSettingsHandler = meteor.subscribe('saleSetting', onReady: () {
      meteor.collection('rest_saleSettings').listen((result) {
        if (result.isNotEmpty && _selectedBranch != null) {
          //  call method only 1 time when sale settings data updated
          debounce.run(() {
            getSaleSetting(branchId: _selectedBranch!.id);
          });
        }
      });
    });
  }

  void getSaleSetting({required String branchId}) async {
    Map<String, dynamic> selector = {"branchId": branchId};
    Map<String, dynamic> result =
        await meteor.call('rest.findSaleSetting', args: [
      {'selector': selector}
    ]);
    SaleSettingModel toListModel = SaleSettingModel.fromJson(result);
    // set sale setting state
    _saleSetting = toListModel;
    notifyListeners();
  }

  void startSubscribeBranch(UserModel currentUser) {
    // Keep listening to branch collection from server
    Map<String, dynamic> branchSelector = {"status": "Active"};

    // check current user isn't role 'super'
    if (!UserService.userInRole(roles: 'super', overpower: false)) {
      List<dynamic> branchPermissions = currentUser.profile.branchPermissions;
      branchSelector['_id'] = {'\$in': branchPermissions};
    }

    // subscribe branch
    _subBranchHandler =
        meteor.subscribe('app.branches', args: [branchSelector], onReady: () {
      meteor.collection('app_branches').listen((result) {
        List<BranchModel> toListModel =
            result.values.toList().map((e) => BranchModel.fromJson(e)).toList();
        //set branches state
        _branches = toListModel;
        if (_branches.isNotEmpty) {
          // set selected branches
          _selectedBranch = branches.first;
        }
        notifyListeners();
      });
    });
  }

  void setBranch({required BranchModel branch}) {
    _selectedBranch = branch;
    getSaleSetting(branchId: branch.id);
    if (_currentUser != null) {
      getDepartment(currentUser: _currentUser!, branchId: branch.id);
    }
    notifyListeners();
  }

  void startSubscribeDepartment() {
    // Keep listening to branch collection from server
    final debounce = Debounce(delay: const Duration(milliseconds: 500));
    // subscribe department
    _subDepartmentHandler = meteor.subscribe('rest.department', onReady: () {
      meteor.collection('rest_departments').listen((result) {
        if (result.isNotEmpty &&
            _currentUser != null &&
            _selectedBranch != null) {
          //  call method only 1 time when department data updated
          debounce.run(() {
            getDepartment(
                currentUser: _currentUser!, branchId: _selectedBranch!.id);
          });
        }
      });
    });
  }

  void getDepartment(
      {required UserModel currentUser, required String branchId}) async {
    Map<String, dynamic> selector = {};
    Map<String, dynamic> options = {
      'sort': {'createdAt': 1}
    };
    // check current user is role 'super' & 'admin'
    if (UserService.userInRole(roles: ['super', 'admin'])) {
      selector['branchId'] = branchId;
    } else {
      List<dynamic> depIds = currentUser.profile.depIds;
      selector['branchId'] = branchId;
      selector['_id'] = {'\$in': depIds};
    }
    List<dynamic> result = await meteor.call('rest.findDepartments', args: [
      {'selector': selector, 'options': options}
    ]);
    List<DepartmentModel> toListModel =
        result.map((d) => DepartmentModel.fromJson(d)).toList();
    // set departments state
    _departments = toListModel;
    if (_departments.isNotEmpty) {
      // set selected department
      _selectedDepartment = _departments.first;
    }
    notifyListeners();
  }

  void setDepartment({required DepartmentModel department}) {
    _selectedDepartment = department;
    notifyListeners();
  }
}
