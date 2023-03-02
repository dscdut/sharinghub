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

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
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

  static String? validateDateEnd(String? value, String dateStart) {
    if (value != null) {
      if (value.isEmpty) {
        return LocaleKeys.validator_field_required.tr();
      } else if (DateFormat('dd/MM/yyyy')
          .parse(value)
          .isBefore(DateFormat('dd/MM/yyyy').parse(dateStart))) {
        return LocaleKeys.validator_validator_invalid_date_end.tr();
      } else if (value.isEmpty) {
        return LocaleKeys.validator_field_required.tr();
      }
    }

    return null;
  }
}
