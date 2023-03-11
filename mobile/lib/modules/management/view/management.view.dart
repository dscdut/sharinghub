import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/management/bloc/management.bloc.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManagementBloc(),
      child: const _ManagementView(),
    );
  }
}

class _ManagementView extends StatelessWidget {
  const _ManagementView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementBloc, ManagementState>(
      builder: (context, state) {
        return const Scaffold();
      },
    );
  }
}
