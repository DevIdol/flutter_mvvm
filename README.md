# flutter_mvvm

## Getting Started

### Setup Flutter Version Management (FVM)
```shell
dart pub global activate fvm

fvm list

fvm releases

fvm install 3.24.3

fvm use 3.24.3
```

### Running Build Runner for Code Generation
```shell
fvm flutter pub run build_runner build --delete-conflicting-outputs
or 
flutter pub run build_runner build --delete-conflicting-output
```
