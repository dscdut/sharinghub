/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/BeVietnamPro-Bold.ttf
  String get beVietnamProBold => 'assets/fonts/BeVietnamPro-Bold.ttf';

  /// File path: assets/fonts/BeVietnamPro-Medium.ttf
  String get beVietnamProMedium => 'assets/fonts/BeVietnamPro-Medium.ttf';

  /// File path: assets/fonts/BeVietnamPro-Regular.ttf
  String get beVietnamProRegular => 'assets/fonts/BeVietnamPro-Regular.ttf';

  /// List of all assets
  List<String> get values =>
      [beVietnamProBold, beVietnamProMedium, beVietnamProRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_chat.png
  AssetGenImage get icChat => const AssetGenImage('assets/icons/ic_chat.png');

  /// File path: assets/icons/ic_logout.png
  AssetGenImage get icLogout =>
      const AssetGenImage('assets/icons/ic_logout.png');

  /// File path: assets/icons/ic_remove_user.png
  AssetGenImage get icRemoveUser =>
      const AssetGenImage('assets/icons/ic_remove_user.png');

  /// File path: assets/icons/ic_search.png
  AssetGenImage get icSearch =>
      const AssetGenImage('assets/icons/ic_search.png');

  /// File path: assets/icons/ic_search_dark.png
  AssetGenImage get icSearchDark =>
      const AssetGenImage('assets/icons/ic_search_dark.png');

  /// File path: assets/icons/ic_setting.png
  AssetGenImage get icSetting =>
      const AssetGenImage('assets/icons/ic_setting.png');

  /// File path: assets/icons/ic_share.png
  AssetGenImage get icShare => const AssetGenImage('assets/icons/ic_share.png');

  /// File path: assets/icons/ic_star.png
  AssetGenImage get icStar => const AssetGenImage('assets/icons/ic_star.png');

  /// File path: assets/icons/ic_support.png
  AssetGenImage get icSupport =>
      const AssetGenImage('assets/icons/ic_support.png');

  /// File path: assets/icons/ic_switch.png
  AssetGenImage get icSwitch =>
      const AssetGenImage('assets/icons/ic_switch.png');

  $AssetsIconsLauncherGen get launcher => const $AssetsIconsLauncherGen();
  $AssetsIconsProfileGen get profile => const $AssetsIconsProfileGen();

  /// List of all assets
  List<AssetGenImage> get values => [
        icChat,
        icLogout,
        icRemoveUser,
        icSearch,
        icSearchDark,
        icSetting,
        icShare,
        icStar,
        icSupport,
        icSwitch
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_default_campaign.png
  AssetGenImage get imgDefaultCampaign =>
      const AssetGenImage('assets/images/img_default_campaign.png');

  /// File path: assets/images/img_default_campaign_square.png
  AssetGenImage get imgDefaultCampaignSquare =>
      const AssetGenImage('assets/images/img_default_campaign_square.png');

  /// File path: assets/images/img_defaut_avatar.png
  AssetGenImage get imgDefautAvatar =>
      const AssetGenImage('assets/images/img_defaut_avatar.png');

  /// File path: assets/images/not_found.svg
  SvgGenImage get notFound => const SvgGenImage('assets/images/not_found.svg');

  /// List of all assets
  List<dynamic> get values =>
      [imgDefaultCampaign, imgDefaultCampaignSquare, imgDefautAvatar, notFound];
}

class $AssetsLocalesGen {
  const $AssetsLocalesGen();

  /// File path: assets/locales/en.json
  String get en => 'assets/locales/en.json';

  /// File path: assets/locales/vi.json
  String get vi => 'assets/locales/vi.json';

  /// List of all assets
  List<String> get values => [en, vi];
}

class $AssetsIconsLauncherGen {
  const $AssetsIconsLauncherGen();

  /// File path: assets/icons/launcher/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/icons/launcher/app_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class $AssetsIconsProfileGen {
  const $AssetsIconsProfileGen();

  /// File path: assets/icons/profile/done.svg
  SvgGenImage get done => const SvgGenImage('assets/icons/profile/done.svg');

  /// File path: assets/icons/profile/feedback.svg
  SvgGenImage get feedback =>
      const SvgGenImage('assets/icons/profile/feedback.svg');

  /// File path: assets/icons/profile/ongoing.svg
  SvgGenImage get ongoing =>
      const SvgGenImage('assets/icons/profile/ongoing.svg');

  /// File path: assets/icons/profile/pending.svg
  SvgGenImage get pending =>
      const SvgGenImage('assets/icons/profile/pending.svg');

  /// File path: assets/icons/profile/upcoming.svg
  SvgGenImage get upcoming =>
      const SvgGenImage('assets/icons/profile/upcoming.svg');

  /// List of all assets
  List<SvgGenImage> get values => [done, feedback, ongoing, pending, upcoming];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLocalesGen locales = $AssetsLocalesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
