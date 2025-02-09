<img alt="image" src="https://flow-labs.io/img/logo/logo-white.png" width="300px"/>

Developed by [Flow Labs](https://flow-labs.io/) 🚀

# Flutter Kit

This starter kit was created to address the challenges of initializing a project. At Flow Labs, we identified recurring patterns when starting a project: state management, authentication, forms, alerts, snackbars, styles, authentication, users, rules and more. The idea behind this repository is to consolidate all the knowledge we’ve gained from building apps into a single resource.

This kit is not a "framework"; rather, it's a guide for initializing a project with useful tools, popular libraries, folder structures, widgets, and more. The key idea is flexibility: developers have the freedom to choose their preferred structure. The goal of this repository is to be a helpful starting point without imposing rigid constraints on developers.

## Screenshots

<div style="display: flex; flex-direction: column; align-items: center;">
  <img src="https://github.com/user-attachments/assets/045dc628-f343-4fad-819c-2041f563da8b" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/e41d62e6-2498-4820-b950-fc7a0384668f" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/9c89a8a6-886e-410e-a55a-1982ab844679" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/3864c504-81bc-4e5e-96f2-7835760b98b5" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/fcbf9d52-5d92-470b-9a89-ae96186bb9d5" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/2c55e900-3a3c-41df-a4e8-c2dcd61ad716" width="312px"/> 
  <img src="https://github.com/user-attachments/assets/572c0397-180d-4523-8d88-7bcabbcb606a" width="312px"/>
  <img src="https://github.com/user-attachments/assets/e6343f5e-f582-40d7-805a-e47455dedd7f" width="312px"/>
  <img src="https://github.com/user-attachments/assets/8dfd5cff-1154-43d9-a889-0def38a21495" width="312px"/>
  <img src="https://github.com/user-attachments/assets/f1cadad8-4568-42be-98d9-6d18491a3a6a" width="312px"/>
  <img src="https://github.com/user-attachments/assets/45174e7a-c8a6-4999-a153-bddf145d90e3" width="312px"/>
  <img src="https://github.com/user-attachments/assets/79999edf-f05d-4bdd-ae45-17034fd4c47c" width="312px"/>
</div>

https://github.com/user-attachments/assets/770d044f-48d2-4402-81ad-04b9bc44a714

https://github.com/user-attachments/assets/23c022ec-fa74-4810-abbd-3d5d567ff8e1

## Platforms

* Android
* IOS

## Features

* Sign In
  * Google
  * Apple
  * Facebook
* Sign In/Up Email-Password
  * Email/Password
  * Validate Email
  * Forgot Password
  * Reset Password
* Profile
* Locked Screen (Biometric)
* Preferences
  * Language
  * Theme
    * Light
    * Dark
* Delete User
* Local Notifications
  * Push Notifications
  * Schedule Push Notifications
  * Listeners
* Notifications Screen
* Public Onboarding
* Emulators
* Export data

## Index

* Download Kit
* Firebase
  * Install firebase CLI
  * Create firebase projects
  * Configuration services
    * Authentication
      * Google
      * Apple
      * Facebook
      * Email and password
    * Firebase Database
    * Storage
    * Functions
  * Deploy
    * Rules
* Flutter App
  * Configuration initial project
    * Install VGV project
    * Add dependencies
    * Copy the app_initial
    * Set Firebase environments in the project
  * Create the app
  * Install the kit
* Set platforms
  * IOS
    * Set BundleId
    * Set Min Version iOS
    * Add Permissions
    * Sign in with Apple
    * Sign in with Google
    * Sign in with Facebook
      * Set Bundle ID
      * Set Bundle ID (Alternative)
      * Set env Info.plist
    * Edit AppDelegate
    * Set Push Notifications from Firebase
      * Xcode
      * Apple Developer and Firebase
    * Biometric
  * Android
    * Set Namespace
    * Update min-sdk-version
    * Sign in with Google
    * Sign in with Facebook
      * Set Facebook keys
      * Set Hashes and Package Name
      * Set Hashes and Package Name (Alternative)
    * Biometric config
    * Config Schedule Notification
    * Biometric
* Emulators
* Export data from Firebase
  * Firebase Auth
  * Firestore
* Notifications
  * Local
  * Remote

## Download Kit

This is the first step to do something with the kit

```
git clone https://github.com/Flowlabsio/flutter_starter_kit.git <project-name>

cd <project-name>

# Open project with vscode
code .
```

## Firebase

### Install firebase CLI

```
# Download CLI
curl -sL https://firebase.tools | bash

# Or from npm
npm install -g firebase-tools

# Login in firebase
firebase login
```

### Create firebase projects 

We will go to create the firebase projects for each environment

1. Open ```firebase/Makefile``` and rename the var ```PROJECT_NAME```

Clarification: If you will have more than three envirnments, add you other envirnments in the var ```ENVIRONMENTS``` on ```firebase/Makefile``` 

2. Create the projects for each envirnments

```
cd firebase

make create_firebase_project
```

This command could be failed because the name is used on another project (and the names of the projects could be unique), if that happen try to run the next command for each failed project

```
firebase projects:create <project-name>-<env>
```

Or go to the console and drop the projects created and start again this process. Or create manually

### Configuration services

This configuration is the basic setup to use the ```app_initial``` this app use four services in Firabase, Authentication and Firestore Database, Storage and Functions

<img width="242" alt="image" src="https://github.com/user-attachments/assets/43e2b919-e607-48d7-b5c1-58094931ea7c" />

You must to cofig every services in each environment. Or if you want to only start with ```development``` (or another) you can only set that and then the another environments

#### Authentication

The Sign-in methods should be three
1. Email and password (iOS and Android)
2. Google (iOS and Android)
3. Apple (iOS)

<img width="1007" alt="image" src="https://github.com/user-attachments/assets/1ed8e897-a498-452a-a6ea-96677453332a" />

##### Google

1. Select "Google"

<img width="975" alt="image" src="https://github.com/user-attachments/assets/af44ab9d-4d3e-4eb3-9e97-41cbf75ec66f" />

2. Set enable and set the facing name (you can change this later)

<img width="674" alt="image" src="https://github.com/user-attachments/assets/18eaef44-9ce5-4a67-afc6-0c5dfde0f419" />

You will see this title when you try to sign-in with Google in the app.

<img width="307" alt="image" src="https://github.com/user-attachments/assets/bba70a65-bf52-4eae-9c74-10a2201dcb29" />

3. Press "Save"

<img width="965" alt="image" src="https://github.com/user-attachments/assets/d09b178b-f92a-4d1c-8f5d-1fb510406190" />

##### Apple

1. Select "Apple"

<img width="983" alt="image" src="https://github.com/user-attachments/assets/ec300031-ba91-4856-866a-64fb14e67f3d" />

2. Press "Save"

<img width="782" alt="image" src="https://github.com/user-attachments/assets/56db5852-625f-425e-a32d-ddf694a2ef86" />

##### Facebook

Clarification: The Auth Emulator does not support facebook.com sign-in

1. Create an app in Facebook console (```https://developers.facebook.com/```)

Clarification: You could create an app for environment

<img width="1349" alt="image" src="https://github.com/user-attachments/assets/2a0573a5-97de-4152-b1ac-4cb481a91aba" />

2. Select the Auth service

<img width="832" alt="image" src="https://github.com/user-attachments/assets/0f7cf76a-24e4-49b4-87ca-afc10432e892" />

3. Select "I don’t want to connect a business portfolio yet."

<img width="1079" alt="image" src="https://github.com/user-attachments/assets/92f939e1-5659-48b4-8eb5-171b9c87dd4d" />

4. Go to App Settings -> Basic

<img width="318" alt="image" src="https://github.com/user-attachments/assets/1b059444-1ed9-4f2b-b32f-d72a945b324c" />

5. Copy the "App ID" and the "App secret"

<img width="794" alt="image" src="https://github.com/user-attachments/assets/b875ecb7-b6fa-4937-98e6-ed531e8eeef1" />

6. Go to Firebase Console and add Facebook provider in the Authentication service

<img width="1002" alt="image" src="https://github.com/user-attachments/assets/9890d41e-060b-4bb6-a009-32328c57c3b6" />

7. Paste the "App ID" and the "App secret", set enabled and press "Save" 

<img width="974" alt="image" src="https://github.com/user-attachments/assets/266bfe35-ab50-436f-96d5-ddc46dc27251" />

8. Press "Edit" facebook provider

<img width="978" alt="image" src="https://github.com/user-attachments/assets/a179de0d-0ba2-4499-b5c6-8a0cb39171d6" />

9.  Copy the OAuth redirect link

<img width="597" alt="image" src="https://github.com/user-attachments/assets/e21f7feb-69c5-4e0f-8d1e-2cb5c2def084" />

10. Go back to the Facebook dashboard, press "Use cases"

<img width="321" alt="image" src="https://github.com/user-attachments/assets/456747b5-d549-4dbf-b624-e297d48f1897" />

11. Press "Customize"

<img width="1030" alt="image" src="https://github.com/user-attachments/assets/788f6075-7664-404c-8522-3d5e98beb203" />

12. Select "Settings"

<img width="334" alt="image" src="https://github.com/user-attachments/assets/7589255d-9a53-4888-93d4-59e330f8300c" />

13. Look the input "Valid OAuth Redirect URIs" and paste the OAuth redirect link from Firebase

<img width="615" alt="image" src="https://github.com/user-attachments/assets/545befac-76ec-48a8-b1b3-18df17e82abc" />

14. Select "Permissions"

<img width="331" alt="image" src="https://github.com/user-attachments/assets/a2e76dab-b9d9-4c28-ab36-112f16fdb4dd" />

15. Look "email" and press "Add"

<img width="958" alt="image" src="https://github.com/user-attachments/assets/b5f81d24-914d-4020-ae1e-3d69ba8e5aa9" />

16. Go to App Settings -> Basic (again)

<img width="323" alt="image" src="https://github.com/user-attachments/assets/2240c791-c3fe-40a2-bfcc-ced99f3ead94" />

17. Got to App roles -> Roles

<img width="318" alt="image" src="https://github.com/user-attachments/assets/2a11d219-0c93-4071-a2ae-2eac5870dcf8" />

18. Press "Add People"

<img width="204" alt="image" src="https://github.com/user-attachments/assets/c4f60a4e-92d4-4712-8f1c-93371e4c021f" />

19. Add the user that are allow to use this service (facebook username). This user should have an facebook developer account

<img width="645" alt="image" src="https://github.com/user-attachments/assets/98ecfc5d-4468-4b62-b186-5390d2e91b4e" />

##### Email and password

1. Select "Email/Password"

<img width="976" alt="image" src="https://github.com/user-attachments/assets/c16de8b8-0281-497c-b80b-649010ea49be" />

2. Press "Save"

<img width="995" alt="image" src="https://github.com/user-attachments/assets/cbb4575e-3478-459d-b07c-0b2b10551990" />

#### Firebase Database

1. Enter in "Firebase Database" and press in "Create Database"

<img width="481" alt="image" src="https://github.com/user-attachments/assets/b93863d1-48d7-4b8e-92c1-003ec6171c47" />

2. Choose a location

<img width="844" alt="image" src="https://github.com/user-attachments/assets/139e5e8e-d6ad-4982-b191-1feeda49d0a2" />

3. Press "Create"

<img width="838" alt="image" src="https://github.com/user-attachments/assets/ae1a919a-953a-4bbe-a030-93c294d15e67" />

#### Storage

Both Storage and Functions will need to set a "Billing Account". This point is important because if you dont do that you won't be able to use this services instead with the emulators

1. Go to the "Storage" section and press "Upgrade project"

<img width="1005" alt="image" src="https://github.com/user-attachments/assets/865c7077-f61b-4b82-9134-4f9e098500c0" />

3. If you have an account, choose one of them, otherwise, create one

<img width="939" alt="image" src="https://github.com/user-attachments/assets/123a568c-6cdc-4a21-b858-f2ff8c166a6e" />

4. Set a budget

<img width="714" alt="image" src="https://github.com/user-attachments/assets/d8923d7d-3e06-4992-a23e-c712b54d7fef" />

5. After that you will see the button "Get started", press it

<img width="453" alt="image" src="https://github.com/user-attachments/assets/2939f9ef-7174-4fa2-bee0-3602215ec65f" />

6. Select your location

<img width="776" alt="image" src="https://github.com/user-attachments/assets/2bcd1300-cb40-4f50-b43d-57ea86f3bb99" />

7. Press "Create"

<img width="776" alt="image" src="https://github.com/user-attachments/assets/30301464-f81a-4a70-adaa-cc0059b61c56" />

#### Functions

1. Press "Get started"

<img width="445" alt="image" src="https://github.com/user-attachments/assets/f94b7ec3-4168-413c-b463-d2b90b93eb46" />

2. Press "Continue"

<img width="633" alt="image" src="https://github.com/user-attachments/assets/3f9efa52-62ba-46f8-a4f5-5979d48a637c" />

3. Press "Finish"

<img width="632" alt="image" src="https://github.com/user-attachments/assets/9add966c-e749-4cb9-96a3-857d912ba2b0" />

### Deploy

#### Rules

Go to ```/firebase``` and select the project ```firebase use <project-name>-<env>```

Deploy the rules to Firebase
```
firebase deploy --only firestore:rules
firebase deploy --only storage
```

## Flutter App

This starter kit use the template of Very Good Ventures to generate the app. The team believe it's a great standard to lunch an app. Therefore we will follow the next steps to install the CLI and generate the app. 

### Install VGV project

1. Install the VGV CLI

```
dart pub global activate very_good_cli
```

2. Run one by one the commands to create the project and leave every file and file in the root folder

```
# Go to the root of the project

# Create the project
very_good create flutter_app <project-name>

# Copy project files
rsync -avh --ignore-existing <project-name>/ .

# Delete the other project
rm -rf <project-name>
```

### Add dependencies

```
flutter pub add app_ui --path=./kit/app_ui
flutter pub add app_core --path=./kit/app_core
flutter pub add app_helpers --path=./kit/app_helpers

flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
flutter pub add json_annotation
flutter pub add dev:json_serializable
flutter pub add dev:icons_launcher

flutter pub add go_router \
  equatable \
  flutter_native_splash \
  reactive_forms \
  google_sign_in \
  sign_in_with_apple \
  flutter_facebook_auth \
  firebase_core \
  firebase_auth \
  cloud_firestore \
  firebase_storage \
  image_cropper \
  image_picker \
  permission_handler \
  shared_preferences \
  internet_connection_checker_plus \
  device_info_plus \
  firebase_messaging \
  flutter_local_notifications \
  timezone \
  crypto \
  smooth_page_indicator \
  local_auth
```

And update the version

```
flutter pub upgrade --major-versions
```

### Copy the app_initial

1. Delete the folders

```
rm -rf lib/app lib/counter test/counter
```

2. Update ```app_test.dart```

```
echo "import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('', (tester) async {
      expect(true, true);
    });
  });
}" > test/app/view/app_test.dart
```

1. Replace localizations

```
rm -rf lib/l10n && mv kit/app_initial/lib/l10n lib/l10n
```

1. Move the ```kit/app_initial/lib/src``` to ```lib/```

```
cp -r kit/app_initial/lib/src lib/
```

2. Go to ```kit/app_initial/lib/bootstrap.dart.template``` copy the content and paste in ```lib/bootstrap.dart```

```
cp kit/app_initial/lib/bootstrap.dart.template lib/bootstrap.dart
```

3. Run this command to fix the path's dependencies

```
./replace_text.sh ./lib "app_initial" "<project-name>"

flutter pub get
```

8. Go to every ```main_<env>``` and fix the ```App``` dependencie

```
import 'package:<project-name>/src/app/app.dart';
```

6. Delete the folder ```kit/app_initial```

```
rm -rf kit/app_initial
```

### Set Firabase environments in the project

Before to start with this step remember to finish all the steps about create projects in the "Firebase" section

1. Instal flutterfire_cli to config the firebase console with the app

```
dart pub global activate flutterfire_cli
```

2. Then config run this command

```
./configure_firebase.sh \
    --project="<project-name>-<env>" \
    --ios-bundle-id="com.<org>.<project-name>.<env>" \
    --android-package-name="com.<org>.<project-name>.<env>" \
    --env="<env>"
```

3. Set the platforms

<img width="823" alt="image" src="https://github.com/user-attachments/assets/47e51403-2d00-4ba1-be47-f906a59c512f" />

If you go to 

<img width="435" alt="image" src="https://github.com/user-attachments/assets/86f3db88-9b5f-465b-9e44-92156e15fb9b" />

At the seccion "Your apps", you will see your apps

<img width="996" alt="image" src="https://github.com/user-attachments/assets/63f3b9e7-38fd-41ed-b6bf-3877e3a7ba81" />

Will apear four new files in ```environments/<env>/```.

```
* firebase_options.dart
* GoogleService-Info.plist
* google-services.json
* firebase.json
```

After run the project with vscode, this files with be paste in their correct position

```
* lib/firebase_options.dart
* ios/Runner/GoogleService-Info.plist
* android/app/google-services.json
* firebase.json
```

Repeat this process for each environment (if you configurated the other environment).

5. From the root of the project run ```make <env>``` to paste the firebase config files in their positions (this proccess in automatic with vscode)

6. Go to ```lib/bootstrap.dart``` and uncomment this lines

```
/// UNCOMMENT THIS LIKE AFTER ADDING FIREBASE CONFIGURATION
// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
```

7. Delete old ```.git``` with ```rm -rf .git```

## Set plaforms

### IOS

#### Set BundleId

1. Open xcode

```
open ios/Runner.xcworkspace
```

2. Press on "Runner"

<img width="272" alt="image" src="https://github.com/user-attachments/assets/a7e74389-2a77-410e-86e9-a369139e4709" />

3. Go to "Signing & Capabilities"

<img width="900" alt="image" src="https://github.com/user-attachments/assets/15b685d3-8951-4cc0-8bbc-0e2e4a3c319d" />

5. Set the bundle id and team for each team (remember that the bundle id must match with the bundle id create in firebase console)

<img width="1079" alt="image" src="https://github.com/user-attachments/assets/bb7d4493-2563-4c46-bfb0-18e60eb24684" />

#### Set Min Version iOS

In the ```Podfile``` set the min version in ```13``` (required by firebase_auth). Go to ```ios/Podfile```, paste

```
platform :ios, '13.0'
```

#### Add Permissions

In the ```Podfile```  paste in the final

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    target.build_configurations.each do |config|
      # You can remove unused permissions here
      # for more information: https://github.com/BaseflowIT/flutter-permission-handler/blob/master/permission_handler/ios/Classes/PermissionHandlerEnums.h
      # e.g. when you don't need camera permission, just add 'PERMISSION_CAMERA=0'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.camera
        'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.photos
        'PERMISSION_PHOTOS=1',

        ## dart: PermissionGroup.notification
        'PERMISSION_NOTIFICATIONS=1',
      ]
    end
  end
end
```

#### Sign in with Apple

1. Press on "Runner"

<img width="272" alt="image" src="https://github.com/user-attachments/assets/a7e74389-2a77-410e-86e9-a369139e4709" />

2. Go to "Signing & Capabilities"

<img width="900" alt="image" src="https://github.com/user-attachments/assets/15b685d3-8951-4cc0-8bbc-0e2e4a3c319d" />

3. Press

<img width="309" alt="image" src="https://github.com/user-attachments/assets/c4a50499-1e6a-4c6c-882b-ce7f9d372d6a" />

5. Add "Sign in with Apple"

<img width="721" alt="image" src="https://github.com/user-attachments/assets/5444dbb2-3083-42eb-81fe-909abb1b0b79" />

#### Sign in with Google

1. Go to ```environments/<env>/GoogleService-Info.plist``` and copy the value of the key ```REVERSED_CLIENT_ID``` and past it in the  ```environments/<env>/Info.plist``` in the ```CFBundleURLSchemes```

If you can't find the ```REVERSED_CLIENT_ID``` it's because the Sign in with Google configuration in firabase is missing.

```
<dict>
    <!-- Put me in the [my_project]/ios/Runner/Info.plist file -->
    <!-- Google Sign-in Section -->
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <!-- TODO Replace this value: -->
                <!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
                <string>[REVERSED_CLIENT_ID]</string>
            </array>
        </dict>
    </array>
    ...
</dict>
```

2. Go to ```environments/<env>/GoogleService-Info.plist``` and copy the value of the key ```CLIENT_ID``` and past it in the ```environments/<env>/env.json``` in the ```GOOGLE_CLIENT_ID```

```
{
  ...
  "GOOGLE_CLIENT_ID": "<CLIENT_ID>",
  ...
}
```

#### Sign in with Facebook

##### Set Bundle ID

1. Go to App Settings -> Basic

<img width="318" alt="image" src="https://github.com/user-attachments/assets/1b059444-1ed9-4f2b-b32f-d72a945b324c" />

2. Scroll to the bottom of the page and press "Add platform"

<img width="1026" alt="image" src="https://github.com/user-attachments/assets/a3154202-9b1a-478e-ba9f-87a44eb3b1ef" />

3. Select iOS

<img width="624" alt="image" src="https://github.com/user-attachments/assets/2e724c0c-d72a-444f-8999-7611a525323a" />

4. Fill the Bundle ID and press "Save changes"

<img width="980" alt="image" src="https://github.com/user-attachments/assets/09642cc2-2449-4890-9bcf-871b65d5699f" />

##### Set Bundle ID (alternative)

1. Go to https://developers.facebook.com/docs/facebook-login/ios

2. Select the app

<img width="699" alt="image" src="https://github.com/user-attachments/assets/592bc717-096b-4aaf-96f1-205871fd3854" />

3. Add your Bundle ID and press "Save"

<img width="847" alt="image" src="https://github.com/user-attachments/assets/1a15f7f8-64e2-4d78-964f-1192179a7c95" />

##### Set env Info.plist

1. Go to App Settings -> Basic

<img width="318" alt="image" src="https://github.com/user-attachments/assets/1b059444-1ed9-4f2b-b32f-d72a945b324c" />

2. Copy the ```App Id``` and go to ```environments/<env>/Info.plist```

Replace the ```FACEBOOK_APP_ID``` by the id (there are two places)

3. Go to App Settings -> Advanced

<img width="315" alt="image" src="https://github.com/user-attachments/assets/782a239f-2c41-40de-b57a-8e76bf815946" />

4. Copy the ```Client token``` and go to ```environments/<env>/Info.plist```

Replace the ```FACEBOOK_CLIENT_TOKEN``` by the token

5. Replace the ```FACEBOOK_DISPLAY_NAME``` by the name what you want to show to the user

#### Edit AppDelegate

1. Edit ```application``` method

```
override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
  GeneratedPluginRegistrant.register(with: self)
  if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
  }
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
```

1. Add import
```
import flutter_local_notifications
```

#### Set Push Notifications from Firebase

##### Xcode

1. Open xcode ```open ios/Runner.xcworkspace```

2. Press Runner -> Signing & Capability

<img width="759" alt="image" src="https://github.com/user-attachments/assets/eeb1177a-cb26-4849-987c-acc7025b2de4" />

3. Press "+ Capability"

<img width="101" alt="image" src="https://github.com/user-attachments/assets/b29baf74-bc9d-4658-8066-fe59f2c5f6b8" />

4. Add "Push Notifications"

<img width="738" alt="image" src="https://github.com/user-attachments/assets/ef896ed5-6011-4a54-9a85-176697026c47" />

5. Press "+ Capability" again

<img width="101" alt="image" src="https://github.com/user-attachments/assets/b29baf74-bc9d-4658-8066-fe59f2c5f6b8" />

6. Add "Background Modes"

<img width="709" alt="image" src="https://github.com/user-attachments/assets/4cfe4360-572c-4f72-b451-320c58bd0447" />

7. Select "Background fetch" and "Remote notifications" 

<img width="554" alt="image" src="https://github.com/user-attachments/assets/53da6ccd-d989-4703-a2f5-f0955347f492" />

##### Apple Developer and Firebase

This key will use for testing and development environment. You can even use this key in another apps, but is not recommended because if you revoke the key, every app that use the key will lose the services

1. Go to Apple Developer (```https://developer.apple.com/account```)

2. Go to "Keys"

<img width="328" alt="image" src="https://github.com/user-attachments/assets/fb7d86c5-38a0-4047-9e81-6429b0a9cf6c" />

3. Add a new key and select the service "Apple Push Notifications service (APNs)"

<img width="1252" alt="image" src="https://github.com/user-attachments/assets/d348e426-8b53-4f6d-93b4-c4ca26a5f7d6" />

4. Download the key

<img width="1192" alt="image" src="https://github.com/user-attachments/assets/0d9c9e3c-0310-4fee-83b1-0d177c9bdd5d" />

5. Go to Firebase console -> Project settings

<img width="431" alt="image" src="https://github.com/user-attachments/assets/68888edc-a700-4805-b7a3-99bcc673f648" />

6. Go to "Cloud Messaging"

<img width="286" alt="image" src="https://github.com/user-attachments/assets/1df2dd7d-38bb-48e6-b4e5-76ad74e67e9c" />

7. Scroll down and set your key

<img width="704" alt="image" src="https://github.com/user-attachments/assets/de9e3835-ef41-4d24-93d1-9d67d6c4a790" />

### Biometric

Uncomment these lines in ```environments/<env>/Info.plist```

```
<!-- Biometric -->
<!-- <key>NSFaceIDUsageDescription</key>
<string>The app requires access to Face ID</string> -->
<!-- Biometric -->
```

### Android

#### Set Namespace

1. Intall the next package

```
flutter pub add --dev change_app_package_name
```

2. Run the command

```
dart run change_app_package_name:main com.<org>.<project-name> --android
```

#### Update build.gradle

Go to ```android/app/build.gradle``` 

1. Set ```minSdkVersion```

```
minSdkVersion 23
```

2. Add ```multiDexEnabled```

```
android {
  defaultConfig {
    multiDexEnabled true
    ...
  }
  ...
}
```

3. Set ```compileSdk```

```
compileSdk 34
```

#### Sign in with Google

1. Excecute
```
# Debug
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android
```

2. Copy the ```SHA1``` and go to the firebase console

<img width="1054" alt="image" src="https://github.com/user-attachments/assets/b7cb95ac-d6ce-4ae3-a5ad-35acf33967f3" />

3. Go to "Project settings"

<img width="260" alt="image" src="https://github.com/user-attachments/assets/af28b3fe-1257-4814-8740-e622b872580a" />

And select the android app

<img width="968" alt="image" src="https://github.com/user-attachments/assets/802c553c-0930-4b5b-a507-5984e251429e" />

5. Press in "Add fingerprint"

<img width="321" alt="image" src="https://github.com/user-attachments/assets/e385dc4d-d255-446a-8994-639b98d42c56" />

6. Paste the  ```SHA1``` and press "Save"

7. Update the environment files with the command ```./configure_firebase.sh``` (check the documentation about generate if you forgot the process)

#### Sign in with Facebook

1. Go to ```environments/<env>/AndroidManifest.xml``` and uncomment the lines between ```<!-- Facebook -->```

##### Set Facebook keys

1. Go to Facebook console and press App Settings -> Basic

<img width="317" alt="image" src="https://github.com/user-attachments/assets/f1b3b5e6-1f70-40b9-a626-673a978e9aca" />

2. Copy the "App id"

<img width="479" alt="image" src="https://github.com/user-attachments/assets/af922c9c-5c90-499f-996d-28e0d9e1bc8b" />

3. Go to ```environments/<env>/strings.xml``` and paste in the ```facebook_app_id``` section

4. Go to Facebook console, and press App Settings -> Advanced

<img width="313" alt="image" src="https://github.com/user-attachments/assets/8e579b33-e02d-41ce-8eac-6639e48c23d7" />

5. Copy the "Client token"

<img width="999" alt="image" src="https://github.com/user-attachments/assets/b4239ef7-c052-4e8e-8d8e-e2a9f5a89cfd" />

6. Go to ```environments/<env>/strings.xml``` and paste in the ```facebook_client_token``` section

##### Set Hashes and Package Name

1. Go to App Settings -> Basic

<img width="323" alt="image" src="https://github.com/user-attachments/assets/2240c791-c3fe-40a2-bfcc-ced99f3ead94" />

2. Scroll to the bottom of the page and press "Add platform"

<img width="1026" alt="image" src="https://github.com/user-attachments/assets/a3154202-9b1a-478e-ba9f-87a44eb3b1ef" />

3. Select Android

<img width="623" alt="image" src="https://github.com/user-attachments/assets/c8328577-c6ee-4219-8365-bc326867eb71" />

4. Select the stores

<img width="636" alt="image" src="https://github.com/user-attachments/assets/461c33c7-881a-4797-9a79-0c5014a52afd" />

5. Fill inputs

<img width="995" alt="image" src="https://github.com/user-attachments/assets/d5ffada7-b25f-4b5e-bdc4-67bb953bcf66" />

To generate the hashes use (use password: "android"):

For development
```
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

For production
``` 
# Generate a keystore for porduction
keytool -genkeypair -v -keystore release-key.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias  release-key

keytool -exportcert -alias release-key -keystore release-key | openssl sha1 -binary | openssl base64
```

After set every field press "Save"

<img width="992" alt="image" src="https://github.com/user-attachments/assets/db8bb06f-b0a5-40f6-a040-b279d07ffa8f" />

##### Set Hashes and Package Name (Alternative)

1. Go to this link https://developers.facebook.com/docs/facebook-login/android/

2. Select the app

<img width="699" alt="image" src="https://github.com/user-attachments/assets/592bc717-096b-4aaf-96f1-205871fd3854" />

3. Associate Your Package Name and Default Class

<img width="862" alt="image" src="https://github.com/user-attachments/assets/e7eb8fd3-9039-406d-8e51-499348f09b68" />

4. Press "Save"

<img width="844" alt="image" src="https://github.com/user-attachments/assets/5a67b004-6c15-4b70-aa7a-0549b98c8846" />

5. Add the Key Hashes

<img width="835" alt="image" src="https://github.com/user-attachments/assets/3ede12a2-c72e-41ec-8f59-f5b8d91ba254" />

To generate the hashes use:

For development
```      
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

For production
``` 
keytool -exportcert -alias YOUR_RELEASE_KEY_ALIAS -keystore YOUR_RELEASE_KEY_PATH | openssl sha1 -binary | openssl base64
```

If you got this error

<img width="368" alt="image" src="https://github.com/user-attachments/assets/a7aa7860-1bad-4879-b850-7eb392fbe841" />

Copy that hash in the hashes list in Facebook Console

##### Error Emulator

If you got this error

```
An internal error has occurred. Cleartext HTTP traffic to 10.0.2.2 not permitted
```

Go to ```AndroidManifest.xml``` and this flags

```
<application
    ...
    android:usesCleartextTraffic="true"
    android:enableOnBackInvokedCallback="true"
    ...
    >
```

#### Biometric config

1. Go to ```android/app/src/main/kotlin/com/<org>/<project-name>/MainActivity.kt```

2. Edit the ```MainActivity.kt```

```
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```

#### Config Schedule Notification

1. Go to ```environments/<env>/AndroidManifest.xml``` and uncomment the lines between. Check the ```manifest``` and ```application``` context because there are two blocks

```
<!-- Schedule Notifications -->
...
<!-- Schedule Notifications -->
```

### Biometric

Uncomment these lines in ```environments/<env>/AndroidManifest.xml```

```
<!-- Biometric -->
<!-- <uses-permission android:name="android.permission.USE_BIOMETRIC"/> -->
<!-- Biometric -->
```

## Emulators

To use the emulators, it's necessary to choose a real firebase project, use one of created before (recommended dev environment).

Clarification: If you want to use any service in the emulator, that service must be activated in the firebase project, for example "Google Sign In", the provider of google should be activated to use it in the emulator

### Run emulators

To start the emulator run

```
cd firebase

firebase use <project-name>-<env>

firebase emulators:start --import export/ --export-on-exit export/
```

### Functions

Install the function dependencies (if you want to use it)

```
cd firebase/functions

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt
```

### Config App

In the app, uncomment this lines in the ```bootstrap.dart```

```
/// USE EMULATORS
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
```

## Export data from Firebase

Clarification: There isn't a "native" way to export the data from firebase and insert in the emulator, 

### Firebase Auth

```
# Select the project
firebase use <project-name>-<env>

# Export data
firebase auth:export export/firebase_users.json --format=JSON --project <project-name>-<env> 
```

### Firestore

1. Install ```firestore-export-import```

```
npm install -g firestore-export-import
```

2. You have to generate new private key from "Project Settings" from Firebase Console.

<img width="433" alt="image" src="https://github.com/user-attachments/assets/5d15ad77-76a9-469a-b982-3aab63a1c23c" />

3. Go to "Service Account" tab

<img width="771" alt="image" src="https://github.com/user-attachments/assets/3b577447-8b84-46b1-80f3-ade8332c8106" />

4. And press "Generate new private key"

<img width="954" alt="image" src="https://github.com/user-attachments/assets/17030fa6-06e0-42d4-8b5b-1ec25bb7c70a" />

6. Move the key ```serviceAccountKey.json``` to the folder ```firebase/```

7. Run

```
cd firebase

firestore-export -a ./<service-account-key>.json -b ./<data-namefile>.json
```

## Notifications

### Local

There is a class call ```LocalNotificationHelper``` and that be able to send notifications. There is two types of notifications instant or scheduled. To use the instant notification call ```LocalNotificationHelper.instance.showNotification()``` and for the scheduled ```.scheduleNotification()```.  To remove a scheduled notification use ```.cancelNotification()```

Also this class have three listeners
* ```onBackgroundMessage```: This method is executed when the app receives a notification in killed or background
* ```onMessage```: This method is executed when the app receives a notification in foreground
* ```onMessageOpenedApp```: This method is executed when the app receives a notification and the user tap on it, a that open the app

### Remote

To use the service there are many options (Firebase Cloud Messaging API, Cloud Functions, use your own service or third-party service with the server). This decision depends on the developer team and available resources. To test the remote push notification there is a function in Cloud Functions that send notifications to each device of a user. This service work in the emulator but remember active the service in Firebase Console. Every request to this service generate a notification document to the user in Firestore

From emulator

```
curl -X POST http://127.0.0.1:5001/<project-name>-<env>/<region>/send_notification \
     -H "Content-Type: application/json" \
     -d '{
         "wheres": [
             {"field": "id", "operator": "==", "value": "<user-id>"}
         ],
         "data": {"key": "value"},
         "title": "Title",
         "body": "Body"
     }'
```

From Firebase

```
curl -X POST https://<region>-<project-name>-<env>.cloudfunctions.net/send_notification \
     -H "Content-Type: application/json" \
     -d '{
         "wheres": [
             {"field": "id", "operator": "==", "value": "<user-id>"}
         ],
         "data": {"key": "value"},
         "title": "Title",
         "body": "Body"
     }'
```

Another option to test the remote notifications is with the offered service by Firebase. Find the FCM token in firestore ```users/{id}/devices/{id}``` the attribute ```fcmToken```

<img width="762" alt="image" src="https://github.com/user-attachments/assets/26ce4dd3-4070-442c-a474-868ad10af83a" />

## Testing

```
# Generate `coverage/lcov.info` file
flutter test --coverage
# Generate HTML report
# Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
genhtml coverage/lcov.info -o coverage/html
# Open the report
open coverage/html/index.html
```

### Edit app name iOS (by env)

1. Open Xcode

2. Go to Runner -> Build Settings

<img width="949" alt="image" src="https://github.com/user-attachments/assets/43097148-d290-4fcd-94d4-4c3456f87398" />

3. Filter by ```FLAVOR_APP_NAME```. You will see the current names

<img width="923" alt="image" src="https://github.com/user-attachments/assets/e364015d-d0d3-42b0-9b1a-116f5d661090" />
