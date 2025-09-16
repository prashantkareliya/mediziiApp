// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIcIconsGen {
  const $AssetsIcIconsGen();

  /// File path: assets/ic_icons/Amulance.svg
  SvgGenImage get amulance => const SvgGenImage('assets/ic_icons/Amulance.svg');

  /// File path: assets/ic_icons/Call-Doc.svg
  SvgGenImage get callDoc => const SvgGenImage('assets/ic_icons/Call-Doc.svg');

  /// File path: assets/ic_icons/Call.svg
  SvgGenImage get call => const SvgGenImage('assets/ic_icons/Call.svg');

  /// File path: assets/ic_icons/Chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/ic_icons/Chat.svg');

  /// File path: assets/ic_icons/Delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/ic_icons/Delete.svg');

  /// File path: assets/ic_icons/Exit.svg
  SvgGenImage get exit => const SvgGenImage('assets/ic_icons/Exit.svg');

  /// File path: assets/ic_icons/Eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/ic_icons/Eye.svg');

  /// File path: assets/ic_icons/Filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/ic_icons/Filter.svg');

  /// File path: assets/ic_icons/Group.svg
  SvgGenImage get group => const SvgGenImage('assets/ic_icons/Group.svg');

  /// File path: assets/ic_icons/Home.svg
  SvgGenImage get home => const SvgGenImage('assets/ic_icons/Home.svg');

  /// File path: assets/ic_icons/Image.svg
  SvgGenImage get image => const SvgGenImage('assets/ic_icons/Image.svg');

  /// File path: assets/ic_icons/Location-1.svg
  SvgGenImage get location1 =>
      const SvgGenImage('assets/ic_icons/Location-1.svg');

  /// File path: assets/ic_icons/Location.svg
  SvgGenImage get location => const SvgGenImage('assets/ic_icons/Location.svg');

  /// File path: assets/ic_icons/Notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/ic_icons/Notification.svg');

  /// File path: assets/ic_icons/PDF.svg
  SvgGenImage get pdf => const SvgGenImage('assets/ic_icons/PDF.svg');

  /// File path: assets/ic_icons/Patient.svg
  SvgGenImage get patient => const SvgGenImage('assets/ic_icons/Patient.svg');

  /// File path: assets/ic_icons/Search.svg
  SvgGenImage get search => const SvgGenImage('assets/ic_icons/Search.svg');

  /// File path: assets/ic_icons/Setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/ic_icons/Setting.svg');

  /// File path: assets/ic_icons/Single.svg
  SvgGenImage get single => const SvgGenImage('assets/ic_icons/Single.svg');

  /// File path: assets/ic_icons/Time.svg
  SvgGenImage get time => const SvgGenImage('assets/ic_icons/Time.svg');

  /// File path: assets/ic_icons/Upload.svg
  SvgGenImage get upload => const SvgGenImage('assets/ic_icons/Upload.svg');

  /// File path: assets/ic_icons/Video.svg
  SvgGenImage get video => const SvgGenImage('assets/ic_icons/Video.svg');

  /// File path: assets/ic_icons/close.svg
  SvgGenImage get close => const SvgGenImage('assets/ic_icons/close.svg');

  /// File path: assets/ic_icons/ic_hospital.png
  AssetGenImage get icHospital =>
      const AssetGenImage('assets/ic_icons/ic_hospital.png');

  /// File path: assets/ic_icons/ic_placeholder.svg
  SvgGenImage get icPlaceholder =>
      const SvgGenImage('assets/ic_icons/ic_placeholder.svg');

  /// File path: assets/ic_icons/upload_file.svg
  SvgGenImage get uploadFile =>
      const SvgGenImage('assets/ic_icons/upload_file.svg');

  /// List of all assets
  List<dynamic> get values => [
    amulance,
    callDoc,
    call,
    chat,
    delete,
    exit,
    eye,
    filter,
    group,
    home,
    image,
    location1,
    location,
    notification,
    pdf,
    patient,
    search,
    setting,
    single,
    time,
    upload,
    video,
    close,
    icHospital,
    icPlaceholder,
    uploadFile,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// File path: assets/images/dr_home_bg.png
  AssetGenImage get drHomeBg =>
      const AssetGenImage('assets/images/dr_home_bg.png');

  /// File path: assets/images/home_bg.png
  AssetGenImage get homeBg => const AssetGenImage('assets/images/home_bg.png');

  /// File path: assets/images/no_active_ride.png
  AssetGenImage get noActiveRide =>
      const AssetGenImage('assets/images/no_active_ride.png');

  /// File path: assets/images/no_ride.png
  AssetGenImage get noRide => const AssetGenImage('assets/images/no_ride.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// File path: assets/images/technician_bg.png
  AssetGenImage get technicianBg =>
      const AssetGenImage('assets/images/technician_bg.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    bg,
    drHomeBg,
    homeBg,
    noActiveRide,
    noRide,
    profile,
    technicianBg,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIcIconsGen icIcons = $AssetsIcIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
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
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
