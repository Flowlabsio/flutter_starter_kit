<img alt="image" src="https://flow-labs.io/img/logo/logo-white.png" style="width: 300px;"/>

Developed by [Flow Labs](https://flow-labs.io/) 🚀

# Flutter Kit

This starter kit was created to address the challenges of initializing a project. At Flow Labs, we identified recurring patterns when starting a project: state management, authentication, forms, alerts, snackbars, styles, authentication, users, rules and more. The idea behind this repository is to consolidate all the knowledge we’ve gained from building apps into a single resource.

This kit is not a "framework"; rather, it's a guide for initializing a project with useful tools, popular libraries, folder structures, widgets, and more. The key idea is flexibility: developers have the freedom to choose their preferred structure. The goal of this repository is to be a helpful starting point without imposing rigid constraints on developers.

## Platforms

* Android
* IOS

## Features

* Sign In
  * Google
  * Apple
* Sign Up 
  * Email/Password
* Validate Email
* Forgot Password
* Profile
  * Firstname
  * Lastname
* Preferences
  * Lenguage
    * English
    * Spanish
  * Theme
    * Light
    * Dark
* Delete user

## Index

* Download Kit
* Firebase 
  * Install firebase CLI 
  * Create firebase projects
  * Configuration services
    * Authentication
      * Google
      * Apple
      * Email and password
    * Firebase Database
* Flutter App
  * Configuration initial project
    * Install VGV project
    * Add dependencies
    * Copy the app_initial
    * Set Firabase environments in the project
  * Create the app
  * Install the kit
* Set plaforms
  * IOS
    * Set BundleId
    * Set Min Version iOS
    * Sign in with Apple
    * Sign in with Google 
  * Android
    * Set Namespace
    * Update min-sdk-version
    * Sign in with Google
* Emulators
  * Run emulators
  * Functions
  * Config App
* Export data from Firebase
  * Firebase Auth
  * Firestore 

## Download Kit

This is the first step to do somthing with the kit

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

Aclaration: If you will have more than three envirnments, add you other envirnments in the var ```ENVIRONMENTS``` on ```firebase/Makefile``` 

2. Create the projects for each envirnments

```
cd firebase

make create_firebase_project
```

This command could be failed because the name is used on another project (and the names of the projects could be unique), if that happen try to run the next command for each failed project

```
firebase projects:create <project-name>-<env>
```

Or go to the console and drop the projects created and start again this process

### Configuration services

This configuration is the basic setup to use the ```app_initial``` this app use two services in Firabase, Authentication and Firestore Database

<img width="213" alt="image" src="https://github.com/user-attachments/assets/05213068-45e4-4f47-94e6-53e336f840aa" />

You must to cofig every services in each environment. Or if you want to only start with ```development``` you can only set that and then the another environments

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

### Copy the app_initial

1. Delete the folder ```lib/app```, ```lib/counter```, ```test/counter```

2. Go to ```test/app/view/app_test.dart``` and paste this

```
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('', (tester) async {
      expect(true, true);
    });
  });
}

```

3. Replace the folder ```lib/l10n/arb``` by ```kit/app_initial/lib/l10n/arb```

2. Move the ```kit/app_initial/lib/src``` to ```lib/```

3. Go to ```kit/app_initial/lib/bootstrap.dart.template``` copy the content and paste in ```lib/bootstrap.dart```

5. Run this command to fix the path's dependencies

```
./replace_text.sh ./lib "app_initial" "<project-name>"

flutter pub get
```

6. Go to every ```main_<env>``` and fix the ```App``` dependencie

```
import 'package:<project-name>/src/app/app.dart';
```

6. Delete the folder ```kit/app_initial``` and ```example``` folder

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

Will apear four new files in ```firebase/environments/<env>/```.

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

4. From the root of the project run ```make <env>``` to paste the firebase config files in their positions (this proccess in automatic with vscode)

5. Go to ```lib/bootstrap.dart``` and uncomment this lines

```
/// UNCOMMENT THIS LIKE AFTER ADDING FIREBASE CONFIGURATION
// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
```

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

4. Set the bundle id and team for each team (remember that the bundle id must match with the bundle id create in firebase console)

<img width="1079" alt="image" src="https://github.com/user-attachments/assets/bb7d4493-2563-4c46-bfb0-18e60eb24684" />

#### Set Min Version iOS

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

#### Update min-sdk-version

Go to ```android/app/build.gradle``` and set ```minSdkVersion```

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

<img width="1054" alt="image" src="https://github.com/user-attachments/assets/b7cb95ac-d6ce-4ae3-a5ad-35acf33967f3" />

3. Go to "Project settings"

<img width="260" alt="image" src="https://github.com/user-attachments/assets/af28b3fe-1257-4814-8740-e622b872580a" />

And select the android app

<img width="968" alt="image" src="https://github.com/user-attachments/assets/802c553c-0930-4b5b-a507-5984e251429e" />

4. Press in "Add fingerprint"

<img width="321" alt="image" src="https://github.com/user-attachments/assets/e385dc4d-d255-446a-8994-639b98d42c56" />

5. Paste the  ```SHA1``` and press "Save"

6. Update the environment files with the command ```./configure_firebase.sh``` (check the documentation about generate if you forgot the proccess)

## Emulators

To use the emulators, it's necessary to choose a real firebase project, use one of created before (recommended dev environment).

Aclaration: If you want to use any service in the amulator, that service must be activated in the firebase project, for example "Google Sign In", the provider of google should be activated to use it in the emulator

### Run emulators

To start the emulator run

```
cd firebase

firebase emulators:start --debug --import export/ --export-on-exit export/
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

In the app, call this methods, you can add that in the ```bootstrap.dart```

```
/// USE EMULATORS
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
```

## Export data from Firebase

Aclaration: There isn't a "native" way to export the data from firebase and insert in the emulator, 

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

5. Move the key ```serviceAccountKey.json``` to the folder ```firebase/```

6. Run

```
cd firebase

firestore-export -a ./<service-account-key>.json -b ./<data-namefile>.json
```
