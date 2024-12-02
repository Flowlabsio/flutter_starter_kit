# Flutter Kit

This starter kit was created to address the challenges of initializing a project. At [Flow-Labs](https://flow-labs.io/), we identified recurring patterns when starting a project: state management, authentication, forms, alerts, snackbars, styles, and more. The idea behind this repository is to consolidate all the knowledge we’ve gained from building apps into a single resource.

The kit has two configurations

* Firebase
  * Create projects in the cloud with their environments
  * Run emulators
* Flutter App
  * Install Very Good Ventures CLI
  * Create the app
  * Update dependencies
  * Add helpers

## Firebase

### Install CLI

```
# Download CLI
curl -sL https://firebase.tools | bash

# Login in firebase
firebase login
```

### Start projects with environments

Open Makefile file and rename the var ```PROJECT_NAME``` (required) and in ```.firebaserc``` (optional)

Then, create the projects with this command:

```
cd firebase && make create_firebase_project
```

### Work with the emulator

The fist thing is install the function dependencies:

```
cd firebase/functions

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt
```

Good, now choose a project to be able to start the emulator (that selection doesn't affect anything in Firebase):

```
firebase use (<project-name>-<env>)
```

And to start the emulator run the next command:

```
firebase emulators:start --debug
```

## Flutte App

This starter kit use the template of Very Good Ventures to generate the app. Therefore we will follow the next steps to install the CLI and generate the app. 

First, install the CLI:

```
dart pub global activate very_good_cli
```

And then make the app:

```
very_good create flutter_app <app-name>
```