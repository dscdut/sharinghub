import 'package:flutter/material.dart';

class UserProfileForm extends StatelessWidget {
  final TextEditingController nameEditingController;
  final TextEditingController phoneEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController addressEditingController;
  final TextEditingController workspaceEditingController;

  const UserProfileForm({
    super.key,
    required this.nameEditingController,
    required this.phoneEditingController,
    required this.emailEditingController,
    required this.addressEditingController,
    required this.workspaceEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
