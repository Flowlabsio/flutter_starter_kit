import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UIIconDark extends UIIcon {
  UIIconDark._singleton();

  static final UIIconDark instance = UIIconDark._singleton();

  final UIAsset _assets = UIAssetDark.instance;
  final UIColor _colors = UIColorDark.instance;

  @override
  Widget logo({double? size}) {
    return SvgPicture.asset(
      _assets.logo,
      height: size ?? UISpacing.space10x,
      width: size ?? UISpacing.space10x,
    );
  }

  @override
  Widget apple({double? size}) {
    return FaIcon(
      FontAwesomeIcons.apple,
      color: _colors.appleLogo,
      size: UISpacing.space5x,
    );
  }

  @override
  Widget google({double? size}) {
    return FaIcon(
      FontAwesomeIcons.google,
      color: _colors.googleLogo,
      size: UISpacing.space4x,
    );
  }

  @override
  Widget facebook({double? size}) {
    return FaIcon(
      FontAwesomeIcons.facebook,
      color: _colors.facebookLogo,
      size: UISpacing.space4x,
    );
  }
}
