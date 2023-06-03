import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/configs/router/app_routes.dart';
import 'package:mobile/generated/assets.gen.dart';

class SwitchLanguageButtonWidget extends StatefulWidget {
  const SwitchLanguageButtonWidget({super.key});

  @override
  State<SwitchLanguageButtonWidget> createState() =>
      _SwitchLanguageButtonWidgetState();
}

class _SwitchLanguageButtonWidgetState
    extends State<SwitchLanguageButtonWidget> {
  String _localeName = '';

  void _getLocales(BuildContext context) {
    setState(() {
      _localeName = Localizations.localeOf(context).languageCode.toUpperCase();
    });
  }

  Future<void> _onSwitchLanguage(BuildContext context) async {
    if (_localeName == 'EN') {
      EasyLocalization.of(context)!.setLocale(
        const Locale('vi', 'VN'),
      );
    } else {
      EasyLocalization.of(context)!.setLocale(
        const Locale('en', 'US'),
      );
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _getLocales(context);
    return GestureDetector(
      onTap: () {
        _onSwitchLanguage(context);
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorStyles.primary1,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _localeName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Assets.icons.icInternet.image(
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
