# Preparing an Android/iOS App for Release

When you're ready to prepare a release version of your app there are some important things you need to do such as change app name, app package name and app icon.

### Video by [Flutterware](https://www.youtube.com/@Flutterware)

[How to Change the Launcher Icon, Package Name, and App Name in Flutter](https://www.youtube.com/watch?v=hiX-SuZ4L40)

### How to change app name

you can use package like [flutter_app_name](https://pub.dev/packages/flutter_app_name) or [rename_app](https://pub.dev/packages/rename_app) or manual.

**Android**

Open `AndroidManifest.xml` (located at `android/app/src/main`)

```
<application android:label="App Name" ...> // Your app name here
```

**iOS**

Open `info.plist` (located at `ios/Runner`)

```
<key>CFBundleDisplayName</key>
<string>App Name</string> // Your app name here
```

### How to change package name

you can use package [change_app_package_name](https://pub.dev/packages/change_app_package_name)

### How to change app icon

you can use package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

**Note:** on iOS 18+ you need to read requirement and the way you design your app icon here [Apple Human Interface Guidelines for App Icons](https://developer.apple.com/design/human-interface-guidelines/app-icons#iOS-iPadOS)

## More Related

[Flutter Meteor Template App](/README.md)
