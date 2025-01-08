lint:
	dart fix --apply
	dart format .
	flutter analyze

cocoa:
	rm -rf ios/Pods
	rm -rf ios/Podfile.lock
	cd ios && pod repo update
	cd ios && pod install

dev:
	cp -f environments/dev/firebase_options.dart lib/firebase_options.dart
	cp -f environments/dev/firebase.json firebase.json
	cp -f environments/dev/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f environments/dev/Info.plist ios/Runner/Info.plist
	cp -f environments/dev/google-services.json android/app/google-services.json
	cp -f environments/dev/env.json env.json
	cp -f environments/dev/AndroidManifest.xml android/app/src/main/AndroidManifest.xml
	cp -f environments/dev/strings.xml android/app/src/main/res/values/strings.xml

stg:
	cp -f environments/stg/firebase_options.dart lib/firebase_options.dart
	cp -f environments/stg/firebase.json firebase.json
	cp -f environments/stg/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f environments/stg/Info.plist ios/Runner/Info.plist
	cp -f environments/stg/google-services.json android/app/google-services.json
	cp -f environments/stg/env.json env.json
	cp -f environments/stg/AndroidManifest.xml android/app/src/main/AndroidManifest.xml
	cp -f environments/stg/strings.xml android/app/src/main/res/values/strings.xml

prod:
	cp -f environments/prod/firebase_options.dart lib/firebase_options.dart
	cp -f environments/prod/firebase.json firebase.json
	cp -f environments/prod/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f environments/prod/Info.plist ios/Runner/Info.plist
	cp -f environments/prod/google-services.json android/app/google-services.json
	cp -f environments/prod/env.json env.json
	cp -f environments/prod/AndroidManifest.xml android/app/src/main/AndroidManifest.xml
	cp -f environments/prod/strings.xml android/app/src/main/res/values/strings.xml

build-ios:
	make prod
	flutter build ios --release --flavor production -t lib/main_production.dart --dart-define-from-file env.json