import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_shadow.wiget.dart';

class InfoCard extends StatelessWidget {
  final Widget child;

  const InfoCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
