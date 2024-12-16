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
	cp -f firebase/environments/dev/firebase_options.dart lib/firebase_options.dart
	cp -f firebase/environments/dev/firebase.json firebase.json
	cp -f firebase/environments/dev/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f firebase/environments/dev/Info.plist ios/Runner/Info.plist
	cp -f firebase/environments/dev/google-services.json android/app/google-services.json 

stg:
	cp -f firebase/environments/stg/firebase_options.dart lib/firebase_options.dart
	cp -f firebase/environments/stg/firebase.json firebase.json
	cp -f firebase/environments/stg/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f firebase/environments/stg/Info.plist ios/Runner/Info.plist
	cp -f firebase/environments/stg/google-services.json android/app/google-services.json 

prod:
	cp -f firebase/environments/prod/firebase_options.dart lib/firebase_options.dart
	cp -f firebase/environments/prod/firebase.json firebase.json
	cp -f firebase/environments/prod/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	cp -f firebase/environments/prod/Info.plist ios/Runner/Info.plist
	cp -f firebase/environments/prod/google-services.json android/app/google-services.json 
