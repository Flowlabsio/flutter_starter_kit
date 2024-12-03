import 'package:app_ui/src/src.dart';

class UIAssetLight implements UIAsset {
  UIAssetLight._singleton();

  static final UIAssetLight _instance = UIAssetLight._singleton();

  factory UIAssetLight() {
    return _instance;
  }

  @override
  String get folderAssetPath => 'packages/app_ui/assets/light';

  @override
  String get logo => '$folderAssetPath/icons/logo.svg';
}
