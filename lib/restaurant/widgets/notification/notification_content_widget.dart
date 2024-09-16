import 'package:flutter/material.dart';
import 'notification_content_list_widget.dart';

class NotificationContentWidget extends StatelessWidget {
  const NotificationContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return NotificationContentListWidget(title: Text('data'));
      },
    );
  }
}
