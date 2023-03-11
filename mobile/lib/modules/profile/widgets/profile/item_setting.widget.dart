import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';

class ItemSettingWidget extends StatelessWidget {
  const ItemSettingWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Image icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 24,
        width: 24,
        child: icon,
      ),
      title: Text(
        title,
        style: TextStyles.regularBody16,
      ),
      onTap: () => onTap,
    );
  }
}
