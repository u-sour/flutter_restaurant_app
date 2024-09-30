import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../models/company/company_accounting_model.dart';
import '../utils/format_currency.dart';
import '../utils/round_number.dart';

class FormatCurrencyWidget extends StatelessWidget {
  final num value;
  final bool enableRoundNumber;
  final String? baseCurrency;
  final bool prefixCurrencySymbol;
  final Color? color;
  final double? priceFontSize;
  final double currencySymbolFontSize;
  final FontWeight fontWeight;

  const FormatCurrencyWidget({
    super.key,
    required this.value,
    this.enableRoundNumber = true,
    this.baseCurrency,
    this.prefixCurrencySymbol = false,
    this.color,
    this.priceFontSize,
    this.currencySymbolFontSize = 20.0,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // get baseCurrency & decimalNumber
    CompanyAccountingModel companyAcc =
        context.select<AppProvider, CompanyAccountingModel>(
            (state) => state.companyAccounting);
    final String defaultBaseCurrency = baseCurrency ?? companyAcc.baseCurrency;
    final int decimalNumber = companyAcc.decimalNumber;
    // init RoundNumber util
    RoundNumber roundNumber = RoundNumber(
        decimalNumber:
            defaultBaseCurrency == 'KHR' ? -decimalNumber : decimalNumber);
    TextStyle currencySymbolStyle = theme.textTheme.bodyLarge!.copyWith(
      fontSize: defaultBaseCurrency == 'KHR' ? currencySymbolFontSize : null,
      color: color ?? theme.colorScheme.onPrimary,
      fontWeight: fontWeight,
      height: defaultBaseCurrency == 'KHR' ? 0.1 : null,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // prefix
        if (prefixCurrencySymbol)
          Text(
            FormatCurrency.getBaseCurrencySymbol(
                baseCurrency: defaultBaseCurrency),
            style: currencySymbolStyle,
            overflow: TextOverflow.ellipsis,
          ),
        // value
        Text(
          FormatCurrency.format(
              value:
                  enableRoundNumber ? roundNumber.round(value: value) : value,
              baseCurrency: defaultBaseCurrency,
              decimalNumber: decimalNumber),
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: priceFontSize,
            color: color ?? theme.colorScheme.onPrimary,
            fontWeight: fontWeight,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        // suffix
        if (!prefixCurrencySymbol)
          Text(
            FormatCurrency.getBaseCurrencySymbol(
                baseCurrency: defaultBaseCurrency),
            style: currencySymbolStyle,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
