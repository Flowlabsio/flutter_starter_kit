import 'package:app_ui/src/src.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UIIconLight implements UIIcon {
  UIIconLight._singleton();

  static final UIIconLight instance = UIIconLight._singleton();

  final UIAsset _assets = UIAssetLight.instance;
  final UIColor _colors = UIColorLight.instance;

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
