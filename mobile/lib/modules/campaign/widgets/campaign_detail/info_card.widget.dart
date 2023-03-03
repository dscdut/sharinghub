import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
