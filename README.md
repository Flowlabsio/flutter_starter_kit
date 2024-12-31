<img alt="image" src="https://flow-labs.io/img/logo/logo-white.png" />

Developed by [Flow Labs](https://flow-labs.io/) 🚀

# Flutter Kit

This starter kit was created to address the challenges of initializing a project. At Flow Labs, we identified recurring patterns when starting a project: state management, authentication, forms, alerts, snackbars, styles, authentication, users, rules and more. The idea behind this repository is to consolidate all the knowledge we’ve gained from building apps into a single resource.

This kit is not a "framework"; rather, it's a guide for initializing a project with useful tools, popular libraries, folder structures, widgets, and more. The key idea is flexibility: developers have the freedom to choose their preferred structure. 

The goal of this repository is to be a helpful starting point without imposing rigid constraints on developers.

* Download Kit
* <a href="#firebase">Firebase</a> 
  * <a href="#install-firebase-cli">Install firebase CLI</a> 
  * <a href="#create-firebase-projects">Create firebase projects</a> 
* <a href="#flutter-app">Flutter App</a> 
  * Install VGV CLI
  * Create the app
  * Install the kit
* <a href="#emulators">Emulators</a> 

## Download Kit
```
git clone https://github.com/Flowlabsio/flutter_starter_kit.git <project-name>

cd <project-name>

# Open project with vscode
code .
```

## <a name="#firebase">Firebase</a>

### <a name="#install-firebase-cli">Install firebase CLI</a>

```
# Download CLI
curl -sL https://firebase.tools | bash

# Or from npm
npm install -g firebase-tools

# Login in firebase
firebase login
```

### <a name="#create-firebase-projects">Create firebase projects</a> 

We will go to make the firebase projects for each environment

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

## <a name="#flutter-app">Flutter App</a>

This starter kit use the template of Very Good Ventures to generate the app. The team believe it's a great standard to lunch an app. Therefore we will follow the next steps to install the CLI and generate the app. 

### Config initial project

First, install the CLI:

```
dart pub global activate very_good_cli
```

And then run one by one the commands to create the project and leave every file and file in the root 

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
# Required
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

Replace the folder ```lib/l10n/arb``` for ```kit/app_initial/lib/l10n/arb```

Move the ```kit/app_initial/lib/src``` to ```lib/```

Run this command to update the dependencies

```
./replace_text.sh ./lib/src "app_initial" "<project-name>"

flutter pub get
```

Delete the folder ```kit/app_initial```

Paste in the file ```lib/bootstrap.dart``` this content, replace the ```<project-name>```

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

Paste in the file ```lib/app/view/app.dart``` this content, replace the ```<project-name>```

```
import 'dart:async';

import 'package:<project-name>/l10n/l10n.dart';
import 'package:<project-name>/src/facades/facades.dart';
import 'package:<project-name>/src/facades/router.dart' as router;
import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

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

    return MaterialApp.router(
      scaffoldMessengerKey: AppKeys.instance.scaffoldMessengerKey,
      theme: UITheme.light,
      darkTheme: UITheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.Router.instance.goRouter,
      onGenerateTitle: (context) {
        Localization.buildContext = context;
        return context.l10n.appName;
      },
    );
  }
}

```

### Set Firabase environments in the project

Before to start with this step remember to finish all the steps about create projects in the "Firebase" section

Instal flutterfire_cli to config the firebase console with the app

```
dart pub global activate flutterfire_cli
```

Then config each flavour (```dev```, ```stg```, ```prod```)

```
flutterfire config \
    --project=<project-name>-<env> \
    --ios-bundle-id=com.<org>.<project-name>.<env> \
    --android-package-name=com.<org>.<project-name>.<env>
```

After run that command. Will apear four new files in the project.

```
* lib/firebase_options.dart
* ios/Runner/GoogleService-Info.plist
* android/app/google-services.json
* firebase.json
```

Copy every file and pase it int the ```firebase/environments/<env>```.

Repeat this process for each environment.

### Set Bundle Id and Namespace

This id need to match with the ios-bundle-id and android-package-name setted in ```flutterfire config```

Android

Intall the package ```change_app_package_name```


```
flutter pub add --dev change_app_package_name
```

Run the command

```
dart run change_app_package_name:main com.<org>.<project-name> --android
```

In ```android/local.properties```

```
flutter.minSdkVersion=23
```

And ```android/app/build.gradle```

```
minSdkVersion localProperties.getProperty('flutter.minSdkVersion').toInteger()
```

In the ```Podfile``` set the min version in ```13``` (required by firebase_auth)

```
platform :ios, '13.0'
```

### Generate fingerprint android in firebase console
```
cd android

./gradlew signingReport or gradlew signingReport

# Paste your SHA1 key in the console

TODO: IMAGE


```
Will need to update ```google-services.json``` and ```firebase_options``` (repeat the process with ```flutterfire config``` command)

### Apple Sign In

#### iOS

```
open ios/Runner.xcworkspace

Go to "Runner" 
* Choose a "Team"
* Check the "Bundle ids" match with Firebase
* Go to "Capability" and add "Sign in with Apple"
```

#### Android

Add a new <meta-data> tag under <application> in the ```android/app/src/main/AndroidManifest.xml```

```
<meta-data
  android:name="flutterEmbedding"
  android:value="2" 
/>
```

will be necessary set ```webAuthenticationOptions```

<img width="1243" alt="image" src="https://github.com/user-attachments/assets/6e3ef9d1-87a7-4ebf-a4ca-02c9901ab5f7" />

<img width="820" alt="image" src="https://github.com/user-attachments/assets/eef52c35-9758-47d8-87d9-28b4deb20595" />


To register a ```clientId``` got to ```https://developer.apple.com/account/resources/identifiers/list/serviceId``` 
```
webAuthenticationOptions: WebAuthenticationOptions(
  clientId: 'register the service id',
  redirectUri: Uri.parse('go to firebase console to copy this url'),
),
```


app.dart
```
import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:app_initial/app_initial.dart' as ai;
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:myapp/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final StreamSubscription<ai.Preference> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = ai.Preference.instance.stream.listen((_) {
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
    final themeMode = ai.Preference.instance.themeMode;
    final locale = ai.Preference.instance.locale;

    return MaterialApp.router(
      scaffoldMessengerKey: AppKeys.instance.scaffoldMessengerKey,
      theme: UITheme.light,
      darkTheme: UITheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ai.Router.instance.goRouter,
      onGenerateTitle: (context) {
        ai.Localization.buildContext = context;
        return context.l10n.appName;
      },
    );
  }
}

```

bootstrap.dart
```
import 'dart:async';
import 'dart:developer';

import 'package:app_initial/app_initial.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:myapp/firebase_options.dart';

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


### <a name="#emulators">Emulators</a> 

To use the emulators, it's necessary to choose a real firebase project, use one of created before (recommended dev environment).

```
firebase use <project-name>-<env>
```

Some services like Firestore doesn't need to be activated in the console of firebase to use it, but other services like auth with google, needed to be activated in the console and use the real credentials as google key, reversed, etc.

To start the emulator run

```
firebase emulators:start --debug
```

Install the function dependencies (if you want to use it)

```
cd firebase/functions

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt
```
