import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../models/company/company_accounting_model.dart';
import '../../utils/format_currency.dart';
import '../../utils/round_number.dart';

class InvoiceFormatCurrencyWidget extends StatelessWidget {
  final num value;
  final bool enableRoundNumber;
  final String? baseCurrency;
  final Color? color;
  final double? priceFontSize;
  final double currencySymbolFontSize;
  final FontWeight? fontWeight;
  final MainAxisAlignment mainAxisAlignment;
  const InvoiceFormatCurrencyWidget(
      {super.key,
      required this.value,
      this.enableRoundNumber = true,
      this.baseCurrency,
      this.color,
      this.priceFontSize,
      this.currencySymbolFontSize = 20.0,
      this.fontWeight = FontWeight.bold,
      this.mainAxisAlignment = MainAxisAlignment.start});

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
    TextStyle currencySymbolStyle = theme.textTheme.bodySmall!.copyWith(
        fontSize: defaultBaseCurrency == 'KHR' ? currencySymbolFontSize : null,
        color: color ?? theme.colorScheme.onPrimary,
        fontWeight: fontWeight,
        height: defaultBaseCurrency == 'KHR' ? 0.1 : null);
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // value
        Text(
          FormatCurrency.format(
              value:
                  enableRoundNumber ? roundNumber.round(value: value) : value,
              baseCurrency: defaultBaseCurrency,
              decimalNumber: decimalNumber),
          style: theme.textTheme.bodySmall!.copyWith(
            fontSize: priceFontSize,
            color: color ?? theme.colorScheme.onPrimary,
            fontWeight: fontWeight,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        // suffix
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
