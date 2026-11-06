# SMART BAR

A futuristic RGB-style Android information display built with Flutter.

## Current prototype

- Arabic/English interface
- News, football, financial markets and clock channels
- Full-screen display mode
- Animated ticker, color selection, speed and font-size controls

**Data notice:** News headlines, football scores and market quotes are demonstration content only. Live data providers and API keys have not been connected yet.

## Build locally

```bash
flutter create --platforms=android --org com.smartbar --project-name smart_bar .
flutter pub get
flutter run
```

## Download Android APK from GitHub

1. Open the **Actions** tab in this repository.
2. Select **Build SMART BAR Android APK**.
3. Open the latest successful workflow run.
4. Download the `smart-bar-android-apk` artifact.
5. Extract the ZIP and install `app-release.apk` on your Android phone.

The workflow runs automatically after every push to `main`.
