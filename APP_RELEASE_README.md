# Preparing an Android/iOS App for Release

When you're ready to prepare a release version of your app there are some important things you need to do such as change app name, app package name and app icon.

### Video by [Flutterware](https://www.youtube.com/@Flutterware)

[How to Change the Launcher Icon, Package Name, and App Name in Flutter](https://www.youtube.com/watch?v=hiX-SuZ4L40)

### How to change app name

you can use package like [flutter_app_name](https://pub.dev/packages/flutter_app_name) or [rename_app](https://pub.dev/packages/rename_app) or manual.

## **Android**

Open `AndroidManifest.xml` (located at `android/app/src/main`)

```
<application android:label="App Name" ...> // Your app name here
```
### Push app to play store
- ### Create an upload keystore
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
#### **Note:** 
យកfile `upload-keystore.jks` ទៅដាក់ក្នុង `[project]/android/app/`
- ### Reference the keystore from the app
Create a file named [project]/android/key.properties that contains a reference to your keystore.
```kotlin
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location> // ../app/upload-keystore.jks
```
- ### Configure signing in gradle
When building your app in release mode, configure gradle to use your upload key. To configure gradle, edit the <project>/android/app/build.gradle file.
1. Define and load the keystore properties file before the android property block.

2. Set the keystoreProperties object to load the key.properties file.
```kotlin
// [project]/android/app/build.gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
   ...
}
```
3. Add the signing configuration before the buildTypes property block inside the android property block.
```kotlin
// [project]/android/app/build.gradle
android {
    // ...

    signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now,
            // so `flutter run --release` works.
            // signingConfig = signingConfigs.debug
            signingConfig = signingConfigs.release
        }
    }
...
}
```
- ### Build app bundle
```js
flutter build appbundle --release
```
## **iOS**

Open `info.plist` (located at `ios/Runner`)

```
<key>CFBundleDisplayName</key>
<string>App Name</string> // Your app name here
```
### Push app to app store
#### **Note:** 
 - ត្រូវបញ្ជាក់ Purpose String ក្នុង Info.plist អោយបានច្បាស់លាល់
### Build
```
flutter build ios
```
- `[project]/ios/Runner.xcworkspace` open file with xcode
- Product -> Archive -> Push app to app store connect

### How to change package name

you can use package [change_app_package_name](https://pub.dev/packages/change_app_package_name)

### How to change app icon

you can use package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

**Note:** on iOS 18+ you need to read requirement and the way you design your app icon here [Apple Human Interface Guidelines for App Icons](https://developer.apple.com/design/human-interface-guidelines/app-icons#iOS-iPadOS)

## More Related

[Flutter Meteor Template App](/README.md)
