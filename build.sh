#!/bin/sh

echo "Deleting old artifacts"
rm -rf build

echo "Compiling new artifacts"
dapktool b tree/current -d -o build/modded.apk

echo "Signing it"
# You can create a fitting keystore using the following command:
# keytool -genkey -v -keystore debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000
# apksigner.jar is the latest build of uber-apk-signer from here: https://github.com/patrickfav/uber-apk-signer
java -jar apksigner.jar --ksDebug debug.keystore --apks build/modded.apk