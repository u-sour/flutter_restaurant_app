import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/constants.dart';

class SaleInvoiceWidget extends StatelessWidget {
  const SaleInvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(
          left: AppStyleDefaultProperties.p,
          top: AppStyleDefaultProperties.p,
          right: AppStyleDefaultProperties.p),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Floor (Table)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(AppDefaultIcons.close))
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('invoice : $index'),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
