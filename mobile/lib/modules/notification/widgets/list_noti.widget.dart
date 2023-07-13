import 'package:flutter/material.dart';
import 'package:mobile/modules/notification/widgets/item_noti.widget.dart';

class ListNotiWidget extends StatelessWidget {
  const ListNotiWidget({
    super.key,
    required this.notis,
  });

  final List<dynamic> notis;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ItemNotiWidget(
        noti: notis[index],
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 10,
        color: Colors.transparent,
      ),
      itemCount: notis.length,
    );
  }
}
