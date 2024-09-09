import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/login_form_provider.dart';
import '../../../../../utils/constants.dart';
import 'cancel_sale_description_cdc_widget.dart';

class CancelSaleCdcWidget extends StatelessWidget {
  final bool enablePassword;
  final bool copy;
  final String confirmSalePassword;
  final GlobalKey<FormBuilderState> fbKey;
  const CancelSaleCdcWidget({
    super.key,
    this.enablePassword = false,
    required this.copy,
    required this.confirmSalePassword,
    required this.fbKey,
  });
  final _prefixFromLabel = 'screens.sale.detail.dialog.confirm.cancelSale.form';
  @override
  Widget build(BuildContext context) {
    return enablePassword
        ? FormBuilder(
            key: fbKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CancelSaleDescriptionCdcWidget(copy: copy),
                const SizedBox(height: AppStyleDefaultProperties.h),
                Consumer<LoginFormProvider>(
                  builder: (context, state, child) => FormBuilderTextField(
                    name: 'password',
                    obscureText: state.showPassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(AppDefaultIcons.password),
                      hintText: '$_prefixFromLabel.password.title'.tr(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            state.switchShowPassword(!state.showPassword),
                        icon: Icon(state.showPassword
                            ? AppDefaultIcons.hidePassword
                            : AppDefaultIcons.showPassword),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.equal(confirmSalePassword,
                          errorText:
                              '$_prefixFromLabel.password.errorText'.tr())
                    ]),
                  ),
                ),
              ],
            ),
          )
        : CancelSaleDescriptionCdcWidget(copy: copy);
  }
}
