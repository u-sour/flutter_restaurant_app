import 'package:easy_localization/easy_localization.dart';

class FormatCurrency {
  static String format(
      {required dynamic value,
      required String baseCurrency,
      required int decimalNumber}) {
    NumberFormat numberFormat = NumberFormat.currency(
      name: baseCurrency,
      decimalDigits:
          (baseCurrency == "KHR" || baseCurrency == "THB") ? 0 : decimalNumber,
      symbol: '',
    );
    return numberFormat.format(value);
  }

  static String getBaseCurrencySymbol({required String baseCurrency}) {
    String symbol = "";
    switch (baseCurrency) {
      case "USD":
        symbol = '\$';
        break;
      case "THB":
        symbol = '฿';
        break;
      case "KHR":
        symbol = '៛';
        break;
      default:
        symbol = 'not found';
    }
    return symbol;
  }

  static String getLocaleByBaseCurrency({required String baseCurrency}) {
    String locale = "";
    switch (baseCurrency) {
      case "USD":
        locale = 'en';
        break;
      case "THB":
        locale = 'th';
        break;
      case "KHR":
        locale = 'km';
        break;
      default:
        locale = 'not found';
    }
    return locale;
  }
}
