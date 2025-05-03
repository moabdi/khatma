
# Flutter App Setup Guide

This guide walks you through setting up a Flutter development environment using VS Code, installing necessary tools, configuring Firebase, and running the app on the web.

---

## 🚀 Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dart SDK](https://dart.dev/get-dart)
- [Flutter SDK (latest)](https://flutter.dev/docs/get-started/install)

---

## 🧩 VS Code Setup

1. Open **VS Code**.
2. Install the following extensions from the Extensions Marketplace:
   - **Flutter**
   - **Dart**

---

## 🔧 Environment Setup

### 1. Check Flutter Environment

Run the following to verify that your environment is correctly set up:

```bash
flutter doctor
```

Make sure all checks pass (Flutter, Dart, and connected devices/plugins).

### 2. Install Dependencies

Run the following command to get all project dependencies:

```bash
flutter pub get
```

### 3. Generate Code 

The project uses code generation (`freezed`, `json_serializable`, `riverpod`), run:

```bash
dart run build_runner build
```

> Use `dart run build_runner watch` during development for continuous rebuilds.

---

## 🔥 Firebase Configuration

To use Firebase, follow these steps:

### 1. Configure Firebase Project

- Go to [Firebase Console](https://console.firebase.google.com/)
- Create a project or select an existing one.
- Add a Web App to get configuration keys.

### 2. Install Firebase Packages

Example (adapt to your needs):

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
```

### 3. Generate Firebase Options File

If using [`flutterfire_cli`](https://firebase.flutter.dev/docs/cli/), run:

```bash
flutterfire configure
```

This generates `firebase_options.dart`.

---

## 🌐 Run the App on Web

To run the Flutter app in a browser:

```bash
flutter run -d chrome
```

To explicitly run using `main.dart`:

```bash
flutter run -d chrome lib/main.dart
```

---

## ✅ Additional Tips

- Use `flutter clean` if you face build or caching issues:

  ```bash
  flutter clean
  flutter pub get
  ```

- For hot reload: press `r` in the terminal after code changes.
- For hot restart: press `R`.

---

## 📂 Project Structure

```
lib/
├── main.dart
├── features/
├──── authentication/
├──── khatma/
├────── application/
├────── data/
├────── domain/
├────── presentation/
├── i18n/
├── themes/
├── routing/
└── firebase_options.dart
```

---

## 📄 License

MIT License. Feel free to use and adapt this project.

---

Happy coding! 🚀
