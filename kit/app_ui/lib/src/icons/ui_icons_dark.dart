import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIIconsDark extends UIIcons {
  @override
  SvgPicture logo({double? size}) {
    return SvgPicture.asset(
      UIAssets.logo,
      colorFilter: const ColorFilter.mode(
        UIColors.black,
        BlendMode.srcIn,
      ),
      height: size ?? UISpacing.space6x,
      width: size ?? UISpacing.space6x,
    );
  }
}
