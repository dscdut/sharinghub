import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/organization/bloc/management/organization_management.bloc.dart';
import 'package:mobile/router/app_routes.dart';

class AddOrganizationFAB extends StatelessWidget {
  const AddOrganizationFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationManagementBloc, OrganizationManagementState>(
      builder: (context, state) {
        return Visibility(
          visible: state.status.isSuccess && state.organizations.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.setOrganization,
                arguments: ArgumentWrapper2(
                  param1: null,
                  param2: context.read<OrganizationManagementBloc>(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
