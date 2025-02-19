import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final ScrollController? controller;
  // final Widget headerChild;
  final Widget bodyChild;
  const ScrollableWidget({
    super.key,
    this.controller,
    // required this.headerChild,
    required this.bodyChild,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        // SliverAppBar(
        //     pinned: true,
        //     floating: true,
        //     // automaticallyImplyLeading: false,
        //     backgroundColor: Colors.white,
        //     flexibleSpace: headerChild),
        // Table body
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return bodyChild;
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
