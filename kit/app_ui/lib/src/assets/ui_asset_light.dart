import 'package:app_ui/src/src.dart';

class UIAssetLight implements UIAsset {
  UIAssetLight._singleton();

  static final UIAssetLight instance = UIAssetLight._singleton();

  @override
  String get folderAssetPath => 'packages/app_ui/assets/light';

  @override
  String get logo => '$folderAssetPath/icons/logo.svg';
}
