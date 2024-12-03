import 'package:app_ui/src/src.dart';

class UIAssetDark implements UIAsset {

  UIAssetDark._singleton();

  static final UIAssetDark _instance = UIAssetDark._singleton();

  factory UIAssetDark() {
    return _instance;
  }

  @override
  String get folderAssetPath => 'packages/app_ui/assets/dark';

  @override
  String get logo => '$folderAssetPath/icons/logo.svg';
}
