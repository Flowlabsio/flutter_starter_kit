import 'package:app_ui/src/src.dart';

class UIAssetDark implements UIAsset {

  UIAssetDark._singleton();

  static final UIAssetDark instance = UIAssetDark._singleton();

  @override
  String get folderAssetPath => 'packages/app_ui/assets/dark';

  @override
  String get logo => '$folderAssetPath/icons/logo.svg';
}
