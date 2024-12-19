import 'package:flutter/material.dart';
import '../../utils/convert_date_time.dart';

enum ConnectionType { bluetooth, ipAddress }

class Invoice extends StatelessWidget {
  final ConnectionType connectionType;
  const Invoice({super.key, this.connectionType = ConnectionType.bluetooth});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Map<String, dynamic>> headerData = [
      {'លរ': '000001'},
      {
        'កាលបរិច្ឆេទ':
            ConvertDateTime.formatTimeStampToString(DateTime.now(), true)
      },
      {'អ្នកលក់': 'Jhon'},
      {'អតិថជន': 'General'},
      {'លេខទូរស័ព្ទ': 'xxx xxx xxx'}
    ];

    List<String> dataTableHeader = ['ទំនិញ', 'ចំនួន', 'តម្លៃ', 'សរុប'];

    List<Map<String, dynamic>> dataTableBody = [
      {'item': '9-lolipop', 'qty': 10, 'price': 1.5, 'amount': 0},
      {'item': 'Pop-Candy', 'qty': 25, 'price': 2.5, 'amount': 0},
      {'item': 'Cola', 'qty': 50, 'price': 2.5, 'amount': 0},
      {'item': '7up', 'qty': 5, 'price': 1.5, 'amount': 0},
      {'item': 'Pespi', 'qty': 100, 'price': 1.5, 'amount': 0},
    ];
    num total = 0;
    for (int i = 0; i < dataTableBody.length; i++) {
      total += dataTableBody[i]['price'] * dataTableBody[i]['qty'];
    }

    return SizedBox(
      width: connectionType.name == 'ipAddress' ? 280.0 : double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'RABBIT',
            style: theme.textTheme.headlineMedium,
          ),
          Text(
            '# Street 153 រ៉ាប៊ីតតិចណូឡូជី, Battambang, Cambodia',
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            'លេខទូរស័ព្ទ ៖ 070 550 880',
            style: theme.textTheme.headlineSmall,
          ),
          const Divider(
            color: Colors.black,
            thickness: 1.5,
          ),
          Text('Invoice',
              style: theme.textTheme.headlineSmall!
                  .copyWith(decoration: TextDecoration.underline)),
          for (int i = 0; i < headerData.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(headerData[i].keys.first.toUpperCase(),
                    style: theme.textTheme.bodyMedium),
                Text(
                  headerData[i].entries.single.value.toString(),
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.black),
              child: DataTable(
                // headingRowColor: MaterialStateColor.resolveWith((states) {
                //   return Colors.grey;
                // }),
                columnSpacing: 0.0,
                dividerThickness: 1.5,
                horizontalMargin: 0.0,
                showBottomBorder: true,
                columns: <DataColumn>[
                  for (int i = 0; i < dataTableHeader.length; i++)
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          dataTableHeader[i],
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
                rows: <DataRow>[
                  for (int i = 0; i < dataTableBody.length; i++)
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            dataTableBody[i]['item'],
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        DataCell(
                          Text(
                            dataTableBody[i]['qty'].toString(),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        DataCell(
                          Text(
                            dataTableBody[i]['price'].toString(),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        DataCell(
                          Text(
                            '${dataTableBody[i]['price'] * dataTableBody[i]['qty']}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  // DataRow(
                  //   cells: <DataCell>[
                  //     for (int i = 0; i < 4; i++)
                  //       (i == 2)
                  //           ? DataCell(
                  //               Text(
                  //                 'សរុប ៖',
                  //                 style: theme.textTheme.bodyText2!
                  //                     .copyWith(fontWeight: FontWeight.bold),
                  //               ),
                  //             )
                  //           : (i == 3)
                  //               ? DataCell(
                  //                   Text(
                  //                     '$total \$',
                  //                     style: theme.textTheme.headline6,
                  //                   ),
                  //                 )
                  //               : const DataCell(
                  //                   Text(''),
                  //                 )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                    text: 'សរុបទាំងអស់ : ',
                    style: theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(
                          text: '$total \$', style: theme.textTheme.titleLarge),
                    ]),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'សូមអរគុណជួបគ្នាម្តងទៀត...',
            style: theme.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
