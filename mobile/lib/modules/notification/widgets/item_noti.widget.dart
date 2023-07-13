import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';

class ItemNotiWidget extends StatelessWidget {
  const ItemNotiWidget({
    super.key,
    required this.noti,
  });

  final dynamic noti;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: noti['isRead'] ? Colors.transparent : ColorStyles.primary4,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noti['content'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              noti['time'],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
