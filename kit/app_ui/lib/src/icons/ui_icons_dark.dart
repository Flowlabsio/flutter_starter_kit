import 'package:app_ui/src/assets/ui_assets_dark.dart';
import 'package:app_ui/src/src.dart';
import 'package:flutter_svg/svg.dart';

class UIIconsDark extends UIIcons {
  final UIAssets _assets = UIAssetsDark();

  @override
  SvgPicture logo({double? size}) {
    return SvgPicture.asset(
      _assets.logo,
      height: size ?? UISpacing.space10x,
      width: size ?? UISpacing.space10x,
    );
  }
}
