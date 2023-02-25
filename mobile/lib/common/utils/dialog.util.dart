import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_popup_route.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

abstract class DialogUtil {
  static bool _isDialogOpen = false;

  static void hideLoading(BuildContext context) {
    if (!_isDialogOpen) return;

    _isDialogOpen = false;
    Navigator.of(context).pop();
  }

  static void showLoading(BuildContext context) {
    _isDialogOpen = true;

    Navigator.of(context).push(
      CustomPopupRoute(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          ),
        ),
        barrierDismissible: false,
      ),
    );
  }

  static Future<void> showCustomDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    required String title,
    TextStyle? titleStyle,
    String? content,
    TextStyle? contentStyle,
    Widget? child,
    String? cancelButtonText,
    VoidCallback? cancelAction,
    String? confirmButtonText,
    VoidCallback? confirmAction,
    bool isConfirmDialog = false,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
          content: child ??
              Text(
                content ?? '',
                style: contentStyle,
              ),
          actions: <Widget>[
            AppRoundedButton(
              width: isConfirmDialog ? null : double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
                cancelAction?.call();
              },
              content: cancelButtonText ?? LocaleKeys.button_cancel.tr(),
              textStyle: TextStyles.s14BoldText.copyWith(
                color: ColorStyles.red400,
              ),
              borderSide: const BorderSide(color: ColorStyles.red400),
              backgroundColor: Colors.transparent,
              height: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            if (isConfirmDialog)
              AppRoundedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  confirmAction?.call();
                },
                content: confirmButtonText ?? LocaleKeys.button_confirm.tr(),
                textStyle: TextStyles.s14BoldText.copyWith(
                  color: Colors.white,
                ),
                height: 45,
              ),
          ],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          buttonPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}
