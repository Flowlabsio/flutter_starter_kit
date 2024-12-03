import 'package:app_ui/src/src.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIIconLight implements UIIcon {
  final UIAsset _assets = UIAssetLight();

  @override
  SvgPicture logo({double? size}) {
    return SvgPicture.asset(
      _assets.logo,
      height: size ?? UISpacing.space10x,
      width: size ?? UISpacing.space10x,
    );
  }
}
