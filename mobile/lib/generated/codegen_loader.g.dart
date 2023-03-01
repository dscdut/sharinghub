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
    "error_occur": "An error has occurred, please try again later",
    "email_address": "Email",
    "password": "Password",
    "register": "Create a account",
    "personal_description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "organization_description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "personal": "Personal",
    "organization": "Organization",
    "full_name": "Full Name",
    "organization_name": "Organization Name",
    "representative_name": "Representative Name"
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
    "login": "Log in",
    "sign_up": "Sign Up",
    "email": "Email",
    "password": "Password",
    "forgot_password": "Forgot password?",
    "confirm_password": "Confirm password",
    "already_have_account": "Already have an account?",
    "have_not_account": "Don't have an account?"
  },
  "validator": {
    "email_required": "Please enter your email",
    "password_required": "Please enter your password",
    "invalid_email": "Invalid email address",
    "incorrect_email_password": "Incorrect email or password",
    "invalid_password": "Password must be at least 8 characters",
    "field_required": "This field is required",
    "not_match_password": "Password and confirm password not match"
  },
  "home": {
    "search": "Search",
    "sort_by": "Sort by: ",
    "newest": "Newest",
    "nearest": "Nearest"
  }
};
static const Map<String,dynamic> vi = {
  "texts": {
    "notification": "Thông báo",
    "success": "Thành công",
    "error_occur": "Đã có lỗi xảy ra, vui lòng thử lại sau",
    "email_address": "Email",
    "password": "Mật khẩu",
    "register": "Đăng kí tài khoản",
    "personal_description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "organization_description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "personal": "Cá nhân",
    "organization": "Tổ chức",
    "full_name": "Họ và tên",
    "organization_name": "Tên tổ chức",
    "representative_name": "Người đại diện"
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
    "forgot_password": "Quên mật khẩu?",
    "confirm_password": "Xác nhận mật khẩu",
    "already_have_account": "Đã có tài khoản?",
    "have_not_account": "Chưa có tài khoản?"
  },
  "validator": {
    "email_required": "Vui lòng nhập email",
    "password_required": "Vui lòng nhập mật khẩu",
    "invalid_email": "Không đúng định dạng email",
    "incorrect_email_password": "Email hoặc mật khẩu không đúng",
    "invalid_password": "Mật khẩu phải có ít nhất 8 kí tự",
    "field_required": "Không được để trống",
    "not_match_password": "Mật khẩu xác nhận không trùng khớp"
  },
  "home": {
    "search": "Tìm kiếm",
    "sort_by": "Sắp xếp theo: ",
    "newest": "Mới nhất",
    "nearest": "Gần nhất"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}
