// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "texts": {
    "notification": "Notification",
    "success": "Success",
    "error_occur": "An error has occurred",
    "email_address": "Email Address",
    "password": "Password"
  },
  "button": {
    "cancel": "Cancel",
    "confirm": "Confirm"
  },
  "root": {
    "home": "Home",
    "profile": "Profile",
    "management": "Management"
  },
  "auth": {
    "welcome_back": "Nice to have you back!",
    "sign_in": "Sign in",
    "login": "Login",
    "sign_up": "Sign up",
    "email": "Email",
    "password": "Password",
    "forgot_password": "Forgot password?"
  },
  "validator": {
    "email_required": "Please enter your email",
    "password_required": "Please enter your password",
    "email_error": "Email must be an email",
    "password_error": "Password is not correct, please try again",
    "password_length": "Password must be at least 8 characters"
  }
};
static const Map<String,dynamic> vi = {
  "texts": {
    "notification": "Thông báo",
    "success": "Thành công",
    "error_occur": "Đã có lỗi xảy ra",
    "email_address": "Email",
    "password": "Mật khẩu"
  },
  "button": {
    "cancel": "Hủy",
    "confirm": "Xác nhận"
  },
  "root": {
    "home": "Trang chủ",
    "profile": "Cá nhân",
    "management": "Quản lý"
  },
  "auth": {
    "welcome_back": "Rất vui khi được gặp lại bạn!",
    "sign_in": "Đăng nhập",
    "login": "Đăng nhập",
    "sign_up": "Đăng ký",
    "email": "Email",
    "password": "Mật khẩu",
    "forgot_password": "Quên mật khẩu?"
  },
  "validator": {
    "email_required": "Vui lòng nhập email",
    "password_required": "Vui lòng nhập mật khẩu",
    "email_error": "Không đúng định dạng email",
    "password_error": "Sai mật khẩu, xin vui lòng thử lại",
    "password_length": "Mật khẩu phải có ít nhất 8 kí tự"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}
