import 'package:app_ui/src/src.dart';
import 'package:flutter_svg/svg.dart';

class UIIconDark extends UIIcon {
  final UIAsset _assets = UIAssetDark();

  @override
  SvgPicture logo({double? size}) {
    return SvgPicture.asset(
      _assets.logo,
      height: size ?? UISpacing.space10x,
      width: size ?? UISpacing.space10x,
    );
  }
}
