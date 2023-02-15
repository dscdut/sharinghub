import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
{{#is_bloc}}{{> bloc_provider }}{{/is_bloc}}{{^is_bloc}}{{> cubit_bloc_provider }}{{/is_bloc}}
  }
}

class _{{name.pascalCase()}}View extends StatelessWidget {
  const _{{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
{{#is_bloc}}{{> bloc_builder }}{{/is_bloc}}{{^is_bloc}}{{> cubit_bloc_builder }}{{/is_bloc}}
  }
}
