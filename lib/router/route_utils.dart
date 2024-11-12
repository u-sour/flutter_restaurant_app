import 'package:flutter/material.dart';
import '../restaurant/utils/constants.dart';
import '../utils/constants.dart';

enum SCREENS {
  connection,
  splash,
  onBoarding,
  login,
  dashboard,
  saleTable,
  sale,
  invoiceToKitchen,
  invoice,
  reports,
  saleReport,
  saleDetailReport,
  profitAndLossByItemReport,
  saleReceiptReport,
  formBuilder,
  formBuilderDefault,
  formBuilderValidation,
  profile,
  myProfile,
  settings,
  printer,
  logout,
  error
}

extension AppScreenExtension on SCREENS {
  String get toPath {
    switch (this) {
      case SCREENS.dashboard:
        return "/";
      case SCREENS.saleTable:
        return "/restaurant/sale-table";
      case SCREENS.sale:
        return "/restaurant/sale";
      case SCREENS.invoiceToKitchen:
        return "/restaurant/invoice-to-kitchen";
      case SCREENS.invoice:
        return "/restaurant/invoice";
      case SCREENS.reports:
        return "/restaurant/reports";
      case SCREENS.saleReport:
        return "/restaurant/reports/sale-report";
      case SCREENS.saleDetailReport:
        return "/restaurant/reports/sale-detail-report";
      case SCREENS.profitAndLossByItemReport:
        return "/restaurant/reports/profit-and-loss-by-item-report";
      case SCREENS.saleReceiptReport:
        return "/restaurant/reports/sale-receipt-report";
      case SCREENS.formBuilder:
        return "/form-builder";
      case SCREENS.formBuilderDefault:
        return "form-builder-default";
      case SCREENS.formBuilderValidation:
        return "form-builder-validation";
      case SCREENS.profile:
        return "/profile";
      case SCREENS.myProfile:
        return "my-profile";
      case SCREENS.settings:
        return "/settings";
      case SCREENS.printer:
        return "/printer";
      case SCREENS.login:
        return "/login";
      case SCREENS.logout:
        return "/logout";
      case SCREENS.splash:
        return "/splash";
      case SCREENS.error:
        return "/error";
      case SCREENS.onBoarding:
        return "/start";
      case SCREENS.connection:
        return "/connection";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case SCREENS.dashboard:
        return "dashboard";
      case SCREENS.saleTable:
        return "saleTable";
      case SCREENS.sale:
        return "sale";
      case SCREENS.invoiceToKitchen:
        return "invoiceToKitchen";
      case SCREENS.invoice:
        return "invoice";
      case SCREENS.reports:
        return "report";
      case SCREENS.saleReport:
        return "saleReport";
      case SCREENS.saleDetailReport:
        return "saleDetailReport";
      case SCREENS.profitAndLossByItemReport:
        return "profitAndLossByItemReport";
      case SCREENS.saleReceiptReport:
        return "saleReceiptReport";
      case SCREENS.formBuilder:
        return "formBuilder";
      case SCREENS.formBuilderDefault:
        return "formBuilderDefault";
      case SCREENS.formBuilderValidation:
        return "formBuilderValidation";
      case SCREENS.profile:
        return "profile";
      case SCREENS.myProfile:
        return "myProfile";
      case SCREENS.settings:
        return "settings";
      case SCREENS.printer:
        return "printer";
      case SCREENS.login:
        return "login";
      case SCREENS.splash:
        return "splash";
      case SCREENS.error:
        return "error";
      case SCREENS.onBoarding:
        return "start";
      case SCREENS.connection:
        return "connection";
      default:
        return "dashboard";
    }
  }

  String get toTitle {
    switch (this) {
      case SCREENS.dashboard:
        return "screens.dashboard.title";
      case SCREENS.saleTable:
        return "screens.saleTable.title";
      case SCREENS.reports:
        return "screens.reports.title";
      case SCREENS.saleReport:
        return "screens.reports.customer.children.sale.title";
      case SCREENS.saleDetailReport:
        return "screens.reports.customer.children.saleDetail.title";
      case SCREENS.profitAndLossByItemReport:
        return "screens.reports.customer.children.profitAndLossByItem.title";
      case SCREENS.saleReceiptReport:
        return "screens.reports.customer.children.saleReceipt.title";
      case SCREENS.formBuilder:
        return "screens.formBuilder.title";
      case SCREENS.formBuilderDefault:
        return "screens.formBuilder.children.default.title";
      case SCREENS.formBuilderValidation:
        return "screens.formBuilder.children.validation.title";
      case SCREENS.profile:
        return "screens.profile.title";
      case SCREENS.myProfile:
        return "screens.profile.children.myProfile.title";
      case SCREENS.settings:
        return "screens.settings.title";
      case SCREENS.printer:
        return "screens.printer.title";
      case SCREENS.login:
        return "screens.login.title";
      case SCREENS.logout:
        return "screens.logout.title";
      case SCREENS.splash:
        return "screens.splash.title";
      case SCREENS.connection:
        return "screens.connection.title";
      case SCREENS.error:
        return "screens.error.title";
      case SCREENS.onBoarding:
        return "screens.onBoarding.title";
      default:
        return "screens.dashboard.title";
    }
  }

  String get toReportTitle {
    switch (this) {
      case SCREENS.saleReport:
        return "screens.reports.customer.children.sale.reportTitle";
      case SCREENS.saleDetailReport:
        return "screens.reports.customer.children.saleDetail.reportTitle";
      case SCREENS.profitAndLossByItemReport:
        return "screens.reports.customer.children.profitAndLossByItem.reportTitle";
      default:
        return "screens.reports.customer.children.saleReceipt.reportTitle";
    }
  }

  IconData get toIcon {
    switch (this) {
      case SCREENS.dashboard:
        return AppDefaultIcons.dashboard;
      case SCREENS.reports:
        return RestaurantDefaultIcons.report;
      case SCREENS.formBuilder:
        return AppDefaultIcons.fromBuilder;
      case SCREENS.formBuilderDefault:
        return AppDefaultIcons.fromBuilderDefault;
      case SCREENS.formBuilderValidation:
        return AppDefaultIcons.fromBuilderValidation;
      case SCREENS.profile:
        return AppDefaultIcons.profile;
      case SCREENS.myProfile:
        return AppDefaultIcons.profile;
      case SCREENS.settings:
        return AppDefaultIcons.settings;
      case SCREENS.login:
        return AppDefaultIcons.login;
      case SCREENS.logout:
        return AppDefaultIcons.logout;
      case SCREENS.splash:
        return AppDefaultIcons.splashScreen;
      case SCREENS.error:
        return AppDefaultIcons.error;
      case SCREENS.onBoarding:
        return AppDefaultIcons.onBoarding;
      default:
        return AppDefaultIcons.dashboard;
    }
  }
}
