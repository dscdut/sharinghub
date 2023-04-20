import 'package:easy_localization/easy_localization.dart';
import 'package:mobile/common/extensions/string.extension.dart';
import 'package:mobile/generated/locale_keys.g.dart';

abstract class ValidatorUtil {
  static String? validateEmail(String? value) {
    if (value != null) {
      if (!value.isEmail) {
        return LocaleKeys.validator_invalid_email.tr();
      }
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.length < 8) {
        return LocaleKeys.validator_invalid_password.tr();
      }
    }

    return null;
  }

  static String? validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validator_field_required.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value != null) {
      if (value != password) {
        return LocaleKeys.auth_confirm_password.tr();
      } else if (value.isEmpty) {
        return LocaleKeys.validator_field_required.tr();
      }
    }

    return null;
  }

  static String? validateQuantity(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return LocaleKeys.validator_field_required.tr();
      } else if (int.parse(value) < 1) {
        return LocaleKeys.validator_invalid_quantity.tr();
      }
    }

    return null;
  }

  static String? validateURL(String? value) {
    if (value == null) return null;
    final RegExp regExp = RegExp(
      r'^(https?:\/\/)?([\w.-]+)\.([a-z]{2,})(\/[\w.%+-]+)*\/?(\?[^\s]+)?$',
      caseSensitive: false,
    );
    if (regExp.hasMatch(value)) return null;
    return LocaleKeys.validator_invalid_url.tr();
  }
}
