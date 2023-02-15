import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final style = context.vars['style'];
  final type = context.vars['type'];
  context.vars = {
    ...context.vars,
    'use_basic': style == 'basic',
    'use_equatable': style == 'equatable',
    'is_bloc': type == 'bloc'
  };

  context.logger.info('Complete run pre generate');
}
