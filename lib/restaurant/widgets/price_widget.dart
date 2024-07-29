import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../models/company/company_accounting_model.dart';
import '../utils/format_currency.dart';

class PriceWidget extends StatelessWidget {
  final num price;
  final double? priceFontSize;
  final double baseCurrencyFontSize;
  const PriceWidget(
      {super.key,
      required this.price,
      this.priceFontSize,
      this.baseCurrencyFontSize = 20.0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    CompanyAccountingModel companyAcc =
        context.select<AppProvider, CompanyAccountingModel>(
            (state) => state.companyAccounting);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          FormatCurrency.format(
              value: price,
              baseCurrency: companyAcc.baseCurrency,
              decimalNumber: companyAcc.decimalNumber),
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: priceFontSize,
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          FormatCurrency.getBaseCurrencySymbol(
              baseCurrency: companyAcc.baseCurrency),
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize:
                companyAcc.baseCurrency == 'KHR' ? baseCurrencyFontSize : null,
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
