<img alt="image" src="https://flow-labs.io/img/logo/logo-white.png" style="width: 300px;"/>

Developed by [Flow Labs](https://flow-labs.io/) 🚀

# Flutter Kit

This starter kit was created to address the challenges of initializing a project. At Flow Labs, we identified recurring patterns when starting a project: state management, authentication, forms, alerts, snackbars, styles, authentication, users, rules and more. The idea behind this repository is to consolidate all the knowledge we’ve gained from building apps into a single resource.

This kit is not a "framework"; rather, it's a guide for initializing a project with useful tools, popular libraries, folder structures, widgets, and more. The key idea is flexibility: developers have the freedom to choose their preferred structure. 

The goal of this repository is to be a helpful starting point without imposing rigid constraints on developers.

* Download Kit
* Firebase 
  * Install firebase CLI 
  * Create firebase projects
  * Configuration services 
* Flutter App
  * Configuration initial project  
    * Install VGV project
    * Add dependencies
    * Adding the initial app
    * Set Firabase environments in the project
  * Create the app
  * Install the kit
* Emulators

## Download Kit
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

Open ```firebase/Makefile``` and rename the var ```PROJECT_NAME``` 

Create the projects with this command:

```
cd firebase

make create_firebase_project
```

This command could be failed because the name is used on another project, and the names of the projects could be unique, if that happen try to run the next command for each failed project

```
firebase projects:create <project-name>-<env>
```

### Configuration services

This configuration is the basic setup to use the ```app_initial``` this app use two services in Firabase, Authentication and Firestore Database

<img width="213" alt="image" src="https://github.com/user-attachments/assets/05213068-45e4-4f47-94e6-53e336f840aa" />

You must to cofig every services in each environment

#### Authentication

The Sign-in methods should be three
1. Email and password
2. Google
3. Apple

<img width="1007" alt="image" src="https://github.com/user-attachments/assets/1ed8e897-a498-452a-a6ea-96677453332a" />

##### Google

1. Choose the google option

<img width="975" alt="image" src="https://github.com/user-attachments/assets/af44ab9d-4d3e-4eb3-9e97-41cbf75ec66f" />

2. Set enable

<img width="147" alt="image" src="https://github.com/user-attachments/assets/437a27ff-2b6b-4539-b6b0-a2391d25686a" />

3. Set the facing name (you can change this later). You will see this title when you try to sign-in with google in the app. In production environment only set the name of the project. And set support email (you can change this later).

<img width="674" alt="image" src="https://github.com/user-attachments/assets/18eaef44-9ce5-4a67-afc6-0c5dfde0f419" />

<img width="307" alt="image" src="https://github.com/user-attachments/assets/bba70a65-bf52-4eae-9c74-10a2201dcb29" />

4. Save

<img width="965" alt="image" src="https://github.com/user-attachments/assets/d09b178b-f92a-4d1c-8f5d-1fb510406190" />

##### Apple

1. Choose the apple option

<img width="983" alt="image" src="https://github.com/user-attachments/assets/ec300031-ba91-4856-866a-64fb14e67f3d" />

2. Set enable

<img width="147" alt="image" src="https://github.com/user-attachments/assets/437a27ff-2b6b-4539-b6b0-a2391d25686a" />

3. Save

<img width="782" alt="image" src="https://github.com/user-attachments/assets/56db5852-625f-425e-a32d-ddf694a2ef86" />

##### Email and password

1. Choose the email/password option

<img width="976" alt="image" src="https://github.com/user-attachments/assets/c16de8b8-0281-497c-b80b-649010ea49be" />

2. Set enable

<img width="147" alt="image" src="https://github.com/user-attachments/assets/437a27ff-2b6b-4539-b6b0-a2391d25686a" />

3. Save

<img width="995" alt="image" src="https://github.com/user-attachments/assets/cbb4575e-3478-459d-b07c-0b2b10551990" />

#### Firebase Database

1. Enter in

<img width="239" alt="image" src="https://github.com/user-attachments/assets/fdb2eb7c-659a-4b13-b2bf-0dfa2a5c4b46" />

2. Press on "Create Database"

<img width="481" alt="image" src="https://github.com/user-attachments/assets/b93863d1-48d7-4b8e-92c1-003ec6171c47" />

3. Choose a location

<img width="844" alt="image" src="https://github.com/user-attachments/assets/139e5e8e-d6ad-4982-b191-1feeda49d0a2" />

4. Set "test mode" and press "Create" (we will update the rules latter)

<img width="857" alt="image" src="https://github.com/user-attachments/assets/76d7052c-52a3-4ffe-8840-0adaf25b870e" />

## Flutter App

This starter kit use the template of Very Good Ventures to generate the app. The team believe it's a great standard to lunch an app. Therefore we will follow the next steps to install the CLI and generate the app. 

### Install VGV project

First, install the VGV CLI

```
dart pub global activate very_good_cli
```

And then run one by one the commands to create the project and leave every file and file in the root folder

```
### Positioned in the root of the project

# Create the project
very_good create flutter_app <project-name>

# Copy project files
rsync -avh --ignore-existing <project-name>/ .

# Delete the other project
rm -rf <project-name>
```

### Add dependencies

App dependencies:

```
flutter pub add app_ui --path=./kit/app_ui
flutter pub add app_core --path=./kit/app_core
flutter pub add app_helpers --path=./kit/app_helpers

flutter pub add go_router \
  equatable \
  flutter_native_splash \
  reactive_forms \
  google_sign_in \
  firebase_core \
  firebase_auth \
  cloud_firestore \
  get_it \
  sign_in_with_apple \
  shared_preferences
```

### Adding the initial app

1. Replace the folder ```lib/l10n/arb``` by ```kit/app_initial/lib/l10n/arb```

2. Move the ```kit/app_initial/lib/src``` to ```lib/```

3. Delete the folder ```kit/app_initial```

4. Paste in the file ```lib/bootstrap.dart``` this content

```
import 'dart:async';
import 'dart:developer';

import 'package:<project-name>/src/facades/facades.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:<project-name>/firebase_options.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Preference.instance.init();

  runApp(await builder());
}
```

5. Paste in the file ```lib/app/view/app.dart``` this content

```
import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:<project-name>/l10n/l10n.dart';
import 'package:<project-name>/src/facades/facades.dart';
import 'package:<project-name>/src/facades/router.dart' as router;
import 'package:<project-name>/src/helpers/helpers.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final StreamSubscription<Preference> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = Preference.instance.stream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Preference.instance.themeMode;
    final locale = Preference.instance.locale;

    return ReactiveFormConfig(
      validationMessages: validationMessages,
      child: MaterialApp.router(
        scaffoldMessengerKey: AppKeys.instance.scaffoldMessengerKey,
        theme: UIThemeLight.instance.theme,
        darkTheme: UIThemeDark.instance.theme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router.Router.instance.goRouter,
        onGenerateTitle: (context) {
          Localization.buildContext = context;
          return context.l10n.appName;
        },
      ),
    );
  }
}
```

6. Run this command to fix the path's dependencies

```
./replace_text.sh ./lib "app_initial" "<project-name>"

flutter pub get
```

### Set Firabase environments in the project

Before to start with this step remember to finish all the steps about create projects in the "Firebase" section

Instal flutterfire_cli to config the firebase console with the app

```
dart pub global activate flutterfire_cli
```

Then config run this command

```
./configure_firebase.sh \
    --project="<project-name>-<env>" \
    --ios-bundle-id="com.<org>.<project-name>.<env>" \
    --android-package-name="com.<org>.<project-name>.<env>" \
    --env="<env>"
```

Set the platforms

<img width="823" alt="image" src="https://github.com/user-attachments/assets/47e51403-2d00-4ba1-be47-f906a59c512f" />

If you go to 

<img width="435" alt="image" src="https://github.com/user-attachments/assets/86f3db88-9b5f-465b-9e44-92156e15fb9b" />

At the seccion "Your apps", you will see your apps

<img width="996" alt="image" src="https://github.com/user-attachments/assets/63f3b9e7-38fd-41ed-b6bf-3877e3a7ba81" />

Will apear four new files in the project.

```
* lib/firebase_options.dart
* ios/Runner/GoogleService-Info.plist
* android/app/google-services.json
* firebase.json
```

That new files was saved in the ```firebase/environments/<env>``` folder, and when you run your project with vscode will switch the files depending the environment

Repeat this process for each environment.

## Set plaforms

### Apple

#### Set BundleId

1. Open xcode

```
open ios/Runner.xcworkspace
```

2. Press on "Runner"

<img width="272" alt="image" src="https://github.com/user-attachments/assets/a7e74389-2a77-410e-86e9-a369139e4709" />

3. Go to "Signing & Capabilities"

<img width="900" alt="image" src="https://github.com/user-attachments/assets/15b685d3-8951-4cc0-8bbc-0e2e4a3c319d" />

4. Set the bundle id and team for each team (remember that the bundle id must match with the bundle id create in firebase console)

<img width="1079" alt="image" src="https://github.com/user-attachments/assets/bb7d4493-2563-4c46-bfb0-18e60eb24684" />

#### Set min-version-ios

In the ```Podfile``` set the min version in ```13``` (required by firebase_auth). Go to ```ios/Podfile```, past

```
platform :ios, '13.0'
```

#### Sign in with Apple

1. Press on "Runner"

<img width="272" alt="image" src="https://github.com/user-attachments/assets/a7e74389-2a77-410e-86e9-a369139e4709" />

2. Go to "Signing & Capabilities"

<img width="900" alt="image" src="https://github.com/user-attachments/assets/15b685d3-8951-4cc0-8bbc-0e2e4a3c319d" />

3. Press

<img width="309" alt="image" src="https://github.com/user-attachments/assets/c4a50499-1e6a-4c6c-882b-ce7f9d372d6a" />

4. Add "Sign in with Apple"

<img width="721" alt="image" src="https://github.com/user-attachments/assets/5444dbb2-3083-42eb-81fe-909abb1b0b79" />

#### Sign in with Google

1. Go to ```firebase/environments/<env>/GoogleService-Info.plist``` and copy the value of the key ```REVERSED_CLIENT_ID``` and past it in the  ```firebase/environments/<env>/Info.plist``` in the ```CFBundleURLSchemes```

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

2. Go to ```firebase/environments/<env>/GoogleService-Info.plist``` and copy the value of the key ```CLIENT_ID``` and past it in the ```firebase/environments/<env>/env.json``` in the ```GOOGLE_CLIENT_ID```

```
{
  ...
  "GOOGLE_CLIENT_ID": "<CLIENT_ID>",
  ...
}
```

#### Andoird

#### Set Namespace

1. Intall the next package

```
flutter pub add --dev change_app_package_name
```

2. Run the command

```
dart run change_app_package_name:main com.<org>.<project-name> --android
```

#### Update min-sdk-version

2. Go to ```android/app/build.gradle``` and set ```minSdkVersion```

```
...
minSdkVersion 23
...
```

#### Sign in with Google

1. Excecute
```
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android
```

2. Copy the ```SHA1``` and go to the firebase console

3. Go to "Project settings"

<img width="260" alt="image" src="https://github.com/user-attachments/assets/af28b3fe-1257-4814-8740-e622b872580a" />

And select the android app

<img width="968" alt="image" src="https://github.com/user-attachments/assets/802c553c-0930-4b5b-a507-5984e251429e" />

4. Press in "Add fingerprint"

<img width="321" alt="image" src="https://github.com/user-attachments/assets/e385dc4d-d255-446a-8994-639b98d42c56" />

5. Paste the  ```SHA1``` and "Save"

if you got some error, try to run the app with  ```flutter run --flavor development -t lib/main_development.dart``` to update the libraries

6. Update the environment files with the command ```./configure_firebase.sh``` (check the documentation about generate if you forgot the proccess)

#### Sign in with Apple (Documentation not ready)

1. Go to https://developer.apple.com/account/resources/identifiers/list/serviceId

and press where say "Register an Service ID"

<img width="1282" alt="image" src="https://github.com/user-attachments/assets/307b304d-8a93-47cb-9d5e-bbd46f2be054" />

2. Choose "Service Id" and press "Continue"

<img width="1273" alt="image" src="https://github.com/user-attachments/assets/54e23f6c-0a31-469b-a7ad-42640efe7df5" />

3. Fill the form

<img width="1286" alt="image" src="https://github.com/user-attachments/assets/10fecbac-c23c-4e37-a509-23758e06224d" />

You can choose another "Identifier" ```com.<org>.<project-name>.auth```

4. Registe the Service ID

5. Click your service created

<img width="544" alt="image" src="https://github.com/user-attachments/assets/55c2bdeb-8926-420d-8d2c-e52eac6f8ec5" />

6. Check the "Sign in with Apple" and press "Configuration"

<img width="667" alt="image" src="https://github.com/user-attachments/assets/2ab9f7a4-9aff-42c6-89bd-296a16a0fccb" />

will be necessary set ```webAuthenticationOptions```

<img width="1243" alt="image" src="https://github.com/user-attachments/assets/6e3ef9d1-87a7-4ebf-a4ca-02c9901ab5f7" />

<img width="820" alt="image" src="https://github.com/user-attachments/assets/eef52c35-9758-47d8-87d9-28b4deb20595" />


### Emulators

To use the emulators, it's necessary to choose a real firebase project, use one of created before (recommended dev environment).

Aclaration: If you want to use any service in the amulator, that service must be activated in the firebase project, for example "Google Sign In", the provider of google should be activated to use it in the emulator

### Use emulators

```
firebase use <project-name>-<env>
```

Some services like Firestore doesn't need to be activated in the console of firebase to use it, but other services like auth with google, needed to be activated in the console and use the real credentials as google key, reversed, etc.

To start the emulator run

```
firebase emulators:start --debug --import export/ --export-on-exit export/
```

Install the function dependencies (if you want to use it)

```
cd firebase/functions

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt
```

In the app, call this methods

```
// Connect to Firestore emulator
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

// Connect to Auth emulator
FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
```

## Export data from Firebase

Aclaration: There isn't a way to export the data and insert in the emulator

### Firebase Auth

```
# Select the project
firebase use <project-name>-<env>

# Export data
firebase auth:export export/firebase_users.json --format=JSON --project <project-name>-<env> 
```
