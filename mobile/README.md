# flutter_template

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Run build_runner

Run:

```bash
$ fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Generate localizations

View [document](https://pub.dev/packages/easy_localization) for details

Run:

```bash
$ fvm flutter pub run easy_localization:generate -S assets/locales
$ fvm flutter pub run easy_localization:generate -S assets/locales -f keys -o locale_keys.g.dart
```

## Generate app flavor

View [document](https://pub.dev/packages/flutter_flavorizr) for details

Run:

```bash
$ fvm flutter pub run flutter_flavorizr
```
If you encounter the issue about "tmp script sh" when generate firebase service. You must run: 
```bash
$ fvm flutter pub run flutter_flavorizr -p assets:download,assets:extract,google:firebase,assets:clean
```

## Generate Assets dart code from assets folder

### With Flutter Gen

Install Flutter Gen

```bash
$ dart pub global activate flutter_gen
```

Or add it as a part of build_runner

```bash
dev_dependencies:
  build_runner:
  flutter_gen_runner:
```

Run Flutter Gen
With command line

```bash
$ fluttergen -c pubspec.yaml
```

With build_runner

```bash
$ fvm flutter pub run build_runner build
```

## Generate template code with mason_cli

View [document](https://github.com/felangel/mason/tree/master/packages/mason_cli#readme) for details

### Install mason_cli

Active from https://pub.dev

```bash
$ dart pub global activate mason_cli
```

Or install from https://brew.sh

```bash
$ brew tap felangel/mason
$ brew install mason
```

### Initializing

Get all bricks registered in mason.yaml run:

```bash
$ mason get
```

Then you can use 'mason make' to generate bricks.
Suppose you want to generate a clean module with getx, you should run

```bash
$ mason make bloc_module -o lib/modules
```

## Flutter build

### Build Android release

- fvm flutter build apk --release --flavor <env*name> -t lib/main*<env_name>.dart

Example: Build STAGING

```bash
fvm flutter build apk --release --flavor staging -t lib/main_staging.dart
```

### Bundle Android Release

fvm flutter build appbundle --flavor staging -t lib/main_stating.dart
