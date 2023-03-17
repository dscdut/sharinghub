
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Image icon;
  final void Function() onTap;

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
      onTap: () => onTap(),
    );
  }
}
