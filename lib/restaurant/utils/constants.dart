import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class RestaurantTableStatusColors {
  static const MaterialColor open = AppThemeColors.primary;
  static const MaterialColor isPrintBill = MaterialColor(0xFFf97316, {
    50: Color.fromRGBO(249, 115, 22, .1),
    100: Color.fromRGBO(249, 115, 22, .2),
    200: Color.fromRGBO(249, 115, 22, .3),
    300: Color.fromRGBO(249, 115, 22, .4),
    400: Color.fromRGBO(249, 115, 22, .5),
    500: Color.fromRGBO(249, 115, 22, .6),
    600: Color.fromRGBO(249, 115, 22, .7),
    700: Color.fromRGBO(249, 115, 22, .8),
    800: Color.fromRGBO(249, 115, 22, .9),
    900: Color.fromRGBO(249, 115, 22, 1)
  });
  static const MaterialColor closed = AppThemeColors.failure;
  static const MaterialColor busy = AppThemeColors.warning;
}

class RestaurantDefaultIcons {
  //confirmation
  static const IconData confirmation = Icons.quiz_rounded;

  // branch
  static const IconData branch = Icons.domain;
  // department
  static const IconData department = Icons.store;
  // dashboard
  static const IconData newSale = Icons.deck;
  static const IconData fastSale = Icons.takeout_dining;
  // notification
  static const IconData notification = Icons.notifications;
  static const IconData notificationInvoice = Icons.receipt_long;
  static const IconData notificationInvoiceRead = Icons.circle_outlined;
  static const IconData notificationInvoiceUnread = Icons.circle;
  static const IconData notificationFromChefMonitor = Icons.food_bank;
  static const IconData notificationFromChefMonitorReady = Icons.task_alt;
  static const IconData notificationStock = Icons.inventory;
  static const IconData notificationStockWarning = Icons.error_outline;
  static const IconData removeNotification = Icons.clear;
  // sale table
  static const IconData table = Icons.table_restaurant;
  static const IconData tableStatus = Icons.fiber_manual_record;
  static const IconData chair = Icons.chair_alt;
  static const IconData invoice = Icons.receipt;
  static const IconData customer = Icons.groups;
  // sale
  static const IconData back = Icons.arrow_back_ios_new;
  static const IconData next = Icons.chevron_right;
  static const IconData search = Icons.search;
  static const IconData tableLocation = Icons.room;
  static const IconData invoiceList = Icons.list;
  static const IconData addInvoice = Icons.add;
  static const IconData noImage = Icons.photo;
  static const IconData selectedItem = Icons.check_circle;
  // sale - category
  static const IconData categories = Icons.menu_book;
  static const IconData extraFoods = Icons.soup_kitchen;
  static const IconData catalogCombo = Icons.brunch_dining;
  // sale - detail data table actions
  static const IconData actions = Icons.more_horiz;
  static const IconData edit = Icons.edit;
  static const IconData editNote = Icons.edit_note;
  static const IconData remove = Icons.delete_outline;
  static const IconData removeSelectedItem = Icons.remove_circle_outline;
  static const IconData emptyData = Icons.storage;
  // sale - detail footer actions
  static const IconData changeTable = Icons.move_up;
  static const IconData changeCustomer = Icons.person;
  static const IconData cancelCopy = Icons.content_copy;
  static const IconData chef = Icons.food_bank;
  static const IconData printChefItems = Icons.print;
  static const IconData print = Icons.print;
  static const IconData preview = Icons.receipt_long;
  static const IconData payment = Icons.payments;
  static const IconData saleReceipt = Icons.paid_outlined;
  static const IconData operations = Icons.settings_applications;
  // sale - detail footer actions - operations - children
  static const IconData merge = Icons.merge;
  static const IconData transfer = Icons.swap_horiz;
  static const IconData split = Icons.alt_route;
  static const IconData customerCount = Icons.groups;
  static const IconData cancel = Icons.cancel_outlined;
  // report
  static const IconData report = Icons.description;
  static const IconData templateLayouts = Icons.preview;
  static const IconData reportForm = Icons.fact_check;
  static const IconData submitReportForm = Icons.check_circle_outline;
}
