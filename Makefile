build-android-apk: build-base
	flutter build apk -t lib/main.dart


build-android-appbundle: build-base
	flutter build appbundle -t lib/main.dart